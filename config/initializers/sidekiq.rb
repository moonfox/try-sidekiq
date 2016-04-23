redis_conn = { db: 0, namespace: "try_sidekiq"}

Sidekiq.configure_client do |config|
  config.redis = redis_conn
end

Sidekiq.configure_server do |config|
  config.redis = redis_conn
end