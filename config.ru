require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { db: 0, namespace: 'try_sidekiq' }
end

# 单独运行Sidekiq监控页面
# run Sidekiq::Web

# run Rack::URLMap.new: 嵌入 based on your rack app
# run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)
run Rack::URLMap.new('/sidekiq' => Sidekiq::Web)
