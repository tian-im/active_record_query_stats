# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersLockTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      get root_path

      watch_logger do |output|
        get lock_users_path
        assert_response :success
        assert_match(/total: 3\b/, output.string)
        assert_match(/real: 3\b/, output.string)
        assert_match(/savepoint: 1\b/, output.string)
        assert_match(/rollback: 1\b/, output.string)
        assert_match(/lock: 1\b/, output.string)
      end
    end
  end
end
