source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"

gem "active_median"
gem "active_storage_validations", "0.8.2"
gem "bcrypt", "3.1.13"
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", "3.4.1"
gem "cancancan"
gem "carrierwave"
gem "chartkick"
gem "cocoon"
gem "config"
gem "devise"
gem "faker", "2.1.2"
gem "figaro"
gem "grape"
gem "grape-active_model_serializers"
gem "grape_on_rails_routes"
gem "groupdate"
gem "i18n-js"
gem "image_processing", "1.9.3"
gem "jbuilder", "~> 2.7"
gem "jwt"
gem "kaminari"
gem "mini_magick", "4.9.5"
gem "mysql2"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "paranoia", "~> 2.2"
gem "premailer-rails"
gem "puma", "~> 4.1"
gem "rack-cors", require: "rack/cors"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "rails-i18n"
gem "ransack"
gem "sass-rails", ">= 6"
gem "sidekiq"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", "~> 3.2"
  gem "pry"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner", "~> 1.5"
  gem "pry-byebug"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "simplecov-json"
  gem "simplecov-rcov"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :development, :test do
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development, :test do
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 4.0.1"
  gem "shoulda-matchers", "~> 3.0", require: false
end
