# frozen_string_literal: true

desc 'Test docker images'
task :test do
  puts '*** Testing images ***'.green
  tags.each do |tag|
    Dir.chdir(tag) do
      puts "Running tests on #{org_name}/#{image_name}:#{tag}"
      sh "echo docker run --rm #{registry}/#{org_name}/#{image_name}:#{tag} /bin/sh -c \"echo hello from #{org_name}/#{image_name}:#{tag}\""
    end
  end
end
