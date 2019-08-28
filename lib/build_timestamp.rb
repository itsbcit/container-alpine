# frozen_string_literal: true

def build_timestamp
  timestamp = if ENV['timestamp'].nil?
                Time.now.getutc.to_i
              else
                ENV['timestamp']
              end

  timestamp
end
