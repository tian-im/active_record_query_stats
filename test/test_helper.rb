# frozen_string_literal: true

if ENV['DEEP']
  require 'deep-cover'
else
  # NOTE: simplecov has to stay at the top of everything else to work properly.
  require 'simplecov'
  SimpleCov.minimum_coverage 100
  SimpleCov.start 'rails' do
    add_filter 'lib/active_record_query_stats/version.rb'
    add_filter 'test'
  end
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
# ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
# ActiveRecord::Migrator.migrations_paths << File.expand_path('../db/migrate', __dir__)
require 'rails/test_help'
require 'helpers/logger_helper'
require 'factories'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = "#{ActiveSupport::TestCase.fixture_path}/files"
  ActiveSupport::TestCase.fixtures :all
end
