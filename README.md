# try_sidekiq
try and research sidekiq

# Sidekiq
Concurrency: 默认25个, 官方建议50个, 不能超过100个, 如果25个会crush掉机器, 则调小并发数
sidekiq -c 20 或在sidekiq.yml中设置
