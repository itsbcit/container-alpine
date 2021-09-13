# frozen_string_literal: true

###
# These tests assume that the container has a defined command that stays running indefinitely.
# If the container runs a command without a wait loop, you'll have to redefine the whole testing procedure.

desc 'Test docker images'
task :test do
  # check that the build system is available
  build_system = Docker.new()
  unless build_system.running?
    puts "#{build_system.name} sanity check failed.".red
    exit 1
  end

  puts '*** Testing images ***'.green
  $images.each do |image|
    # basic container test
    begin
      puts "Running tests on #{image.build_tag}".green
      container = `docker run --rm --health-interval=2s -d #{image.build_tag} init-loop`.strip
      exit 1 unless $?.success?

      # wait for container state "running"
      state = ''
      printf 'Waiting for container startup'
      10.times do
        state = `docker inspect --format='{{.State.Status}}' #{container}`.strip
        exit 1 unless $?.success?
        break if state == 'running'
        printf "."
        sleep 1
      end
      puts
      if state != 'running'
        puts "Container failed to reach \"running\" state. Got \"#{state}\"".red
        exit 1
      end

      # if the container has a health check, wait up to 20 seconds for it to be successful
      container_health = `docker inspect --format='{{.State.Health}}' #{container}`.strip
      hashealth = container_health == "<nil>" ? false : true
      if hashealth
        printf 'Waiting for container healthy'
        health_status = ''
        20.times do
          health_status = `docker inspect --format='{{.State.Health.Status}}' #{container}`.strip
          exit 1 unless $?.success?
          break if health_status == 'healthy'
          printf "."
          sleep 1
        end
        puts
        if health_status != 'healthy'
          puts "Container failed to reach \"healthy\" status. Got \"#{health_status}\"".red
          exit 1
        end
      end
      # end of basic container test

      ###
      # put your custom image tests here
      ###

      # end of container tests
    ensure
      sh "docker kill #{container}"
    end
    puts "Testing image #{image.build_tag} successful.".green
  end
end
