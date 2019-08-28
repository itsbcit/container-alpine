# frozen_string_literal: true

require 'erb'
require 'fileutils'
require 'yaml'

$images = []

Dir.glob('lib/*.rb').each { |l| load l } if Dir.exist?('lib')

if File.exist?('metadata.yaml')
  $images = build_objects_array(
    metadata: YAML.safe_load(File.read('metadata.yaml')),
    build_id: build_timestamp
  )
end

Dir.glob('lib/tasks/*.rake').each { |r| load r } if Dir.exist?('lib/tasks')

# initalize the project
