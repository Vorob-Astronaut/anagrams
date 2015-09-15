require 'server_side'
class UserActivityLogsController < ApplicationController
  include ActionController::Live

  def send_message
    response.headers['Content-Type'] = 'text/event-stream'
    redis = Redis.new
    redis.subscribe('crier:transitions') do |on|
      on.message do |event, data|
        response.stream.write "data: #{JSON.dump(data)}"
        response.stream.write "\n\n"
      end
    end
  ensure
    response.stream.close
  end

end
