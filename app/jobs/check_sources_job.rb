class CheckSourcesJob < ActiveJob::Base
  queue_as :default

  after_perform do |job|
    Message.create(message: "Movie streams for #{@count} titles updated")
  end

  def perform(*args)
    client = Canistreamit::Client.new
    @count = 0
    Title.all.each do |t|
      t.check_sources(client)
      @count +=1
    end

  end

  def after(job)
    Message.create(message: "Movie streams for #{@count} titles updated")
  end


end
