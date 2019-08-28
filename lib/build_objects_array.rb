# frozen_string_literal: true

def build_objects_array(options = {})
  build_id = options.fetch(:build_id)
  metadata = options.fetch(:metadata)

  objects_array = []

  files       = metadata['files'].nil?       ? []           : metadata['files']
  labels      = metadata['labels'].nil?      ? []           : metadata['labels']
  registries  = metadata['registries'].nil?  ? []           : metadata['registries']
  suffixes    = metadata['suffixes'].nil?    ? []           : metadata['suffixes']
  variants    = metadata['variants'].nil?    ? { '' => {} } : metadata['variants']
  vars        = metadata['vars'].nil?        ? {}           : metadata['vars']
  versions    = metadata['versions'].nil?    ? { '' => {} } : metadata['versions']

  versions.each do |version, version_params|
    version_params     = version_params.nil?                 ? {} : version_params
    version_files      = version_params['files'].nil?        ? [] : version_params['files']
    version_labels     = version_params['labels'].nil?       ? {} : version_params['labels']
    version_suffixes   = version_params['suffixes'].nil?     ? [] : version_params['suffixes']
    version_tags       = version_params['version_tags'].nil? ? [] : version_params['version_tags']
    version_vars       = version_params['vars'].nil?         ? {} : version_params['vars']
    variants.each do |variant, variant_params|
      variant_params   = variant_params.nil?             ? {} : variant_params
      variant_files    = variant_params['files'].nil?    ? [] : variant_params['files']
      variant_labels   = variant_params['labels'].nil?   ? {} : variant_params['labels']
      variant_suffixes = variant_params['suffixes'].nil? ? [] : variant_params['suffixes']
      variant_vars     = variant_params['vars'].nil?     ? {} : variant_params['vars']
      objects_array << DockerImage.new(
        build_id: build_id,
        files: files + version_files + variant_files,
        image_name: metadata['image_name'],
        labels: labels.merge(version_labels).merge(variant_labels),
        org_name: metadata['org_name'],
        registries: registries,
        suffixes: suffixes + version_suffixes + variant_suffixes,
        variant: variant,
        vars: vars.merge(version_vars).merge(variant_vars),
        version_tags: version_tags,
        version: version
      )
    end
  end

  objects_array
end
