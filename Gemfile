source "https://rubygems.org"
ruby "3.3.4"

gem "rails", "~> 7.0.8"
gem "sqlite3", "~> 1.7"
gem "puma", "~> 6.4"
gem "bootsnap", "~> 1.18", require: false

# add back Sprockets so config.assets.* works
gem "sprockets-rails"

# JS/util gems from the original template (fine to keep)
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# keep our Ruby 3.3 fix
gem "logger", "~> 1.6"

group :development do
  gem "web-console"
  gem "letter_opener"
  gem "letter_opener_web"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "minitest", "~> 5.25"
end
