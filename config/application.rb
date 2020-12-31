require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module OE29RubyHotelManagement
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :vi]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.active_job.queue_adapter = :sidekiq
  end
end
