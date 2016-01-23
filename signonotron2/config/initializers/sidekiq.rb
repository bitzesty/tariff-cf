require "sidekiq"

if ENV['VCAP_SERVICES'].present?
  services = JSON.parse(ENV['VCAP_SERVICES'])
  credentials = services['redis'].first['credentials']
  ENV['REDIS_URL'] = "redis://:#{credentials['password']}@#{credentials['host']}:#{credentials['port']}/"
end

redis_config = { namespace: "signon_sidekiq" }
redis_config[:url] = ENV['REDIS_URL'] if ENV['REDIS_URL']

Sidekiq.configure_server do |config|
  config.redis = redis_config
  config.server_middleware do |chain|
    chain.add Sidekiq::Statsd::ServerMiddleware, env: 'govuk.app.signon', prefix: 'workers'
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
