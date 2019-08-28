# frozen_string_literal: true

desc 'Push to Registry'
task :push do
  unless File.exist? '.build_id'
    puts 'Build and tag images first'.red
    exit(1)
  end
  build_id = File.read('.build_id')
  $images.each do |image|
    puts "Image: #{image.name_tag}"
    image.build_id = build_id
    image.registries.each do |registry|
      ron = image.registry_org_name(registry['url'], registry['org_name'])
      separator = ron.empty? ? '' : '/'
      image.tags.each do |tag|
        next if ron.empty?

        sh "docker push #{ron}#{separator}#{image.name_tag(tag)}"
      end
    end
  end
end
