# 总结: Delayed extensions(让普通类,非Worker类,拥有delay功能)
# 1. User.delay_for(10).create_user("Jack", 20) 会把任务放到默认队列
#   sidekiq会在User类方法中混入delay,delay_for,delay_until方法

# 2. User.delay_for(10, :retry => false, :queue => 'low').create_user("Jack", 20)
#   可以为delay_xxx方法指定sidekiq选项:job所在队列,是否进行重试等

# 3. Sidekiq.remove_delay! 禁用Delayed extensions扩展(只对 Rails application 有效)

# 4. 也可以在实例对象上使用delay方法, 但不建议这么做,因为实例对象的状态会被改变,如果一定要对
#    实例对象进行操作, 应对其父类进行delay, 实时得到实例对象
#    英文原文:I strongly recommend avoiding delaying methods on instances. 
#    This stores object state in Redis which can get out of date, causing stale data problems.

class User
  class << self
    def create_user(name, age)
      sleep 3
      puts "create user with name #{name} and age #{age}"
    end
  end
end
