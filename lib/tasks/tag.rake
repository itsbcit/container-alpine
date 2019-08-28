# frozen_string_literal: true

desc 'Tag docker images'
task :tag do
  puts '*** Tagging images ***'.green
  $images.each do |image|
    puts "Image: #{image.name_tag}"
    image.build_id = File.read('.build_id') if File.exist? '.build_id'
    File.open('.build_id', 'w') { |f| f.write(image.build_id) } unless File.exist? '.build_id'
    image.tags.each do |tag|
      sh "docker tag #{image.base_tag} #{image.name_tag(tag)}"
    end
    image.registries.each do |registry|
      ron = image.registry_org_name(registry['url'], registry['org_name'])
      separator = ron.empty? ? '' : '/'
      image.tags.each do |tag|
        sh "docker tag #{image.base_tag} #{ron}#{separator}#{image.name_tag(tag)}"
      end
    end
  end
end
