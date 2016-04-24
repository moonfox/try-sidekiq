class OurWorker
  include Sidekiq::Worker
  # default_worker_options: 设置Sidekiq默认选项
  # Sidekiq.default_worker_options = { 'backtrace' => true }

  # dead: 达到重试次数后,不放入Dead Job Queue, job直接被放弃
  # sidekiq_options retry: 2, dead: false

  # retry:0 立刻被送到Dead Job Queue
  # sidekiq_options retry: 0 

  # retry: 1 只重试一次,然后被放入Dead Job Queue
  sidekiq_options retry: 1

  # 指定our_queue队列中的job由OurWorker处理
  sidekiq_options queue: 'our_queue'

  # backtrace: 使用backtrace记录错误,这可能会使redis占用大量内存(当有大量失败的job时)
  # 错误信息会记录在Redis里,键为zset类型,整个job的相关信息被Serialization后
  # 包括backtrace信息,所以当启用backtrack后,如果错误的job特别多,则会导致redis占用大量的内存
  # 这个选项要小心使用,否则会占用量大内存
  # backtrace can be true, false or an integer number of lines to save, default false
  sidekiq_options backtrace: true

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

  def self.create_user(name, age)
    puts "create new user with name is #{name}, and age is #{age}"
  end
end

class YourWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'your_queue', retry: 5, backtrace: true

  def perform(complexity)
    case complexity
    when "super_hard"
      puts "charging a credit card..."
      raise "Woops stuff god bad"
      puts "Really took quite a bit of effort"
    when "hard"
      sleep 5
      puts "That was a bit of work"
    else
      sleep 1
      puts "That wasn't a lot of effort"
    end
  end
end