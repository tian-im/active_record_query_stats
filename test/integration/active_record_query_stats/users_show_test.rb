# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersShowTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      user = FactoryBot.create :user
      get root_path

      watch_logger do |output|
        get user_path(user)
        assert_response :success
        assert_match(/total: 1\b/, output.string)
        assert_match(/real: 1\b/, output.string)
        assert_match(/cached: 0\b/, output.string)
        assert_match(/select: 1\b/, output.string)
        assert_match(/insert: 0\b/, output.string)
        assert_match(/update: 0\b/, output.string)
        assert_match(/delete: 0\b/, output.string)
        assert_match(/transaction: 0\b/, output.string)
        assert_match(/savepoint: 0\b/, output.string)
        assert_match(/rollback: 0\b/, output.string)
        assert_match(/lock: 0\b/, output.string)
        assert_match(/other: 0\b/, output.string)
      end
    end
  end
end
