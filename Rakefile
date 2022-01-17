# frozen_string_literal: true

require 'erb'
require 'fileutils'
require 'tempfile'
require 'yaml'
require 'open-uri'

Dir.glob('lib/*.rb').each { |l| load l unless File.exist?("local/#{l[4..-1]}") } if Dir.exist?('lib')
Dir.glob('local/*.rb').each { |l| load l } if Dir.exist?('local')

if File.exist?('metadata.yaml')
  local_metadata = YAML.safe_load(File.read('metadata.yaml'))
else
  puts('WARNING: metadata.yaml not found.')
  local_metadata = {}
end

puts('WARNING: Rakefile library not found.') unless File.exist?('lib')

if File.exist?('lib/metadata-defaults.yaml')
  default_metadata = YAML.safe_load(File.read('lib/metadata-defaults.yaml'))
else
  puts('WARNING: metadata defaults not found.')
  default_metadata = {}
end

if File.exist?('metadata.yaml') && File.exist?('lib')
  $images = build_objects_array(
    metadata: local_metadata,
    default_metadata: default_metadata
  )
end

desc 'Install Rakefile support files'
task :install do
  URI.parse('https://github.com/itsbcit/docker-rakefile/releases/latest/download/lib.zip').open do |archive|
    FileUtils.remove_entry('lib') if File.exist?('lib')
    tempfile = Tempfile.new(['lib', '.zip'])
    File.open(tempfile.path, 'wb') do |f|
      f.write(archive.read)
    end
    system('unzip', tempfile.path)
    tempfile.unlink
  end
end

desc 'Update Rakefile to latest release version'
task :update do
  Rake::Task[:install].invoke
  URI.parse('https://github.com/itsbcit/docker-rakefile/releases/latest/download/Rakefile').open do |rakefile|
    File.open('Rakefile', 'wb') do |f|
      f.write(rakefile.read)
    end
  end
end

Dir.glob('lib/tasks/*.rake').each { |l| load l unless File.exist?("local/tasks/#{l[10..-1]}") } if Dir.exist?('lib/tasks')
Dir.glob('local/tasks/*.rake').each { |l| load l } if Dir.exist?('local/tasks')
