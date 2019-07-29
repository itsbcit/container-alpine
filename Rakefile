require "erb"

# @ripienaar https://www.devco.net/archives/2010/11/18/a_few_rake_tips.php
# Brilliant.
def render_template(template, output, scope)
    tmpl = File.read(template)
    erb = ERB.new(tmpl, 0, "<>")
    File.open(output, "w") do |f|
        f.puts erb.result(scope)
    end
end

maintainer        = 'jesse@weisner.ca, chriswood.ca@gmail.com'
registry          = 'docker.io'
org_name          = 'bcit'
image_name        = 'alpine'
tini_version      = '0.18.0'
de_version        = '1.5'
dockerize_version = '0.6.1'
parent_tags       = [
  '3.10',
  '3.9',
  '3.8',
]
tags              = [
  '3.10',
  '3.9',
  '3.8',
  '3.10-supervisord',
  '3.9-supervisord',
  '3.8-supervisord',
]

unless ENV['registry'].nil?
  registry = ENV['registry']
end

desc "Template, build, tag, push"
task :default do
  Rake::Task[:Dockerfile].invoke
  Rake::Task[:build].invoke
  Rake::Task[:test].invoke
end

desc "Update Dockerfile templates"
task :Dockerfile do
  tags.each do |tag|
    parent_tags.each do |parent_tag|
      if tag.include? parent_tag
        sh "mkdir -p #{tag}"
        render_template("Dockerfile.erb", "#{tag}/Dockerfile", binding)
      end
    end
    if tag.include? "supervisor"
      sh "cp -f supervisor.conf #{tag}/supervisor.conf"
    end
  end
end

desc "Build docker images"
task :build do
  tags.each do |tag|
    Dir.chdir(tag) do
      sh "docker build -t #{registry}/#{org_name}/#{image_name}:#{tag} . --no-cache --pull"
    end
  end
end

desc "Test docker images"
task :test do
  tags.each do |tag|
    Dir.chdir(tag) do
      puts "Running tests on #{org_name}/#{image_name}:#{tag}"
      sh "docker run --rm #{registry}/#{org_name}/#{image_name}:#{tag} /bin/sh -c \"echo hello from #{org_name}/#{image_name}:#{tag}\""
    end
  end
end

desc "Push to Registry"
task :push do
  tags.each do |tag|
    Dir.chdir(tag) do
      sh "docker push #{registry}/#{org_name}/#{image_name}:#{tag}"
    end
  end
end
