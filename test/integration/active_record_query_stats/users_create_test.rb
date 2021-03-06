# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersCreateTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      get root_path

      watch_logger do |output|
        post users_path, params: { user: { first_name: 'John', last_name: 'Doe' } }
        assert_response :found
        assert_match(/total: 3\b/, output.string)
        assert_match(/real: 3\b/, output.string)
        assert_match(/cached: 0\b/, output.string)
        assert_match(/select: 0\b/, output.string)
        assert_match(/insert: 1\b/, output.string)
        assert_match(/update: 0\b/, output.string)
        assert_match(/delete: 0\b/, output.string)
        assert_match(/transaction: 2\b/, output.string)
        assert_match(/savepoint: 2\b/, output.string)
        assert_match(/rollback: 0\b/, output.string)
        assert_match(/lock: 0\b/, output.string)
        assert_match(/other: 0\b/, output.string)
        assert_match(/total: 3\b/, output.string)
      end
    end
  end
end
