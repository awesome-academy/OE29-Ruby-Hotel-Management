# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require "sidekiq"
require "sidekiq/web"
run Rack::URLMap.new(
  "/" => Rails.application,
  "/sidekiq" => Sidekiq::Web
)

