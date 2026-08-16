# frozen_string_literal: true

require "bullet"

# The Bullet::Rack middleware flags N+1 across the entire request/render path,
# which surfaces legacy issues in request and system specs. The quality gate is
# focused on N+1 in the code under test, so we bypass the middleware and rely
# on the RSpec hooks below (which skip request/system specs).
module Bullet
  class Rack
    def call(env)
      @app.call(env)
    end
  end
end

Bullet.enable = true
Bullet.raise = true
Bullet.unused_eager_loading_enable = false
Bullet.bullet_logger = false
Bullet.console = false

RSpec.configure do |config|
  config.before(:each) do |example|
    Bullet.start_request unless request_spec?(example)
  end
  config.after(:each) do |example|
    next if request_spec?(example)

    Bullet.perform_out_of_channel_notifications if Bullet.notification?
    Bullet.end_request
  end
end

def request_spec?(example)
  %i[request system feature].include?(example.metadata[:type])
end
