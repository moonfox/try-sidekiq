require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { db: 0, namespace: 'try_sidekiq' }
end

run Sidekiq::Web

