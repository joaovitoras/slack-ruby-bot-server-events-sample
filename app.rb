# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

Bundler.require :default
require_relative 'config/database'

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end

require_relative 'lib/models'
require_relative 'lib/events'
require_relative 'lib/slash_commands'
require_relative 'lib/actions'
