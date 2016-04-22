require 'sidekiq'

redis_conn = { db: 0}

Sidekiq.configure_client do |config|
  config.redis = redis_conn
end


Sidekiq.configure_server do |config|
  config.redis = redis_conn
end

class OurWorker
  include Sidekiq::Worker
  # dead: 达到重试次数后,不放入Dead Job Queue, job直接被放弃
  # sidekiq_options retry: 2, dead: false

  # retry:0 立刻被送到Dead Job Queue
  # sidekiq_options retry: 0 

  # retry: 1 只重试一次,然后被放入Dead Job Queue
  sidekiq_options retry: 1

  # 自定义重试时间间隔
  # sidekiq_retry_in do |count|
  #   10 * (count + 1) # (i.e. 10, 20, 30, 40)
  # end


  # After retrying so many times, Sidekiq will call the sidekiq_retries_exhausted hook on your Worker if you've defined it. The hook receives the queued message as an argument. This hook is called right before Sidekiq moves the job to the DJQ.
  # 在达到尝试次数后,调用sidekiq_retries_exhausted(hook method)中定义的代码
  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(complexity)
    case complexity
    when "super_hard"  
      puts "charging a credit card..."
      raise "Woops stuff god bad"
      puts "Really took quite a bit of effort"
    when "hard"
      sleep 10
      puts "That was a bit of work"
    else
      sleep 1
      puts "That wasn't a lot of effort"
    end
  end
end