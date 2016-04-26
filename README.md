# try_sidekiq
try and research sidekiq

# Sidekiq
1、Concurrency: 默认25个, 官方建议50个(不要超过50), 超过100个后会有意想不到的错误, 如果25个会crush掉机器, 则调小并发数

2、sidekiq -c 20 或在sidekiq.yml中设置

3、数据库pool: 如果与数据库相连(ActiveRecord)，要保持连接池的数据等于或接3近sidekiq线程的总数量:  pool: 25

# Sidekiq.remove_delay! 
禁用Extension 方法,  只对Rails application 有效, 会移走下列被其扩展的module

[Sidekiq::Extensions::ActiveRecord, Sidekiq::Extensions::ActionMailer, Sidekiq::Extensions::Klass]

#停止Sidekiq

bundle exec sidekiqctl stop

默认为等待10秒, 如果10秒后还有没有完成的job,则强制kill掉