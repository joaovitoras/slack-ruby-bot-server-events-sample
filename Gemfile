# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.3'

gem 'pg'
gem 'activerecord', require: 'active_record'
gem 'otr-activerecord'
gem 'cursor_pagination', github: 'dblock/cursor_pagination', branch: 'misc' # rubocop:disable Bundler/OrderedGems
gem 'irb'
gem 'pry'
gem 'puma'
gem 'slack-ruby-bot-server', '>= 1.1.0'
gem 'slack-ruby-bot-server-events'

group :test do
  gem 'capybara'
  gem 'fabrication'
  gem 'faker'
  gem 'rack-test'
  gem 'rake'
  gem 'rspec'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
  gem 'webrick'
end
