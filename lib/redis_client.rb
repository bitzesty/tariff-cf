class RedisClient
  include Singleton

  attr_reader :connection

  def initialize
    Sidekiq.redis do |redis|
      @connection = redis
    end
  end
end
