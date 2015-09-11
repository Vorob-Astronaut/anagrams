require 'server_side'
class UserActivityLogsController < ApplicationController
  include ActionController::Live

  def send_message
    response.headers['Content-Type'] = 'text/event-stream'
    sse = ServerSide::SSE.new(response.stream)
    begin
      sse.write("Live message should be here")
    rescue IOError
    ensure
      sse.close
    end
  end

end
