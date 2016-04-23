# 20.times {User.delay_for(10).create_user("Jack", 20)}
# 10.times{OurWorker.perform_in(12,"hard")}
# User.delay_for(10) 会把任务放到默认队列,sidekiq会在User类方法中混入delay,delay_for,delay_until方法

class User
  class << self
    def create_user(name, age)
      sleep 3
      puts "create user with name #{name} and age #{age}"
    end
  end
end
