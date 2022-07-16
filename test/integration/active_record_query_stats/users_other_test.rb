# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersOtherTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      get root_path

      watch_logger do |output|
        get other_users_path
        assert_response :success
        assert_match(/total: 1\b/, output.string)
        assert_match(/real: 1\b/, output.string)
        assert_match(/other: 1\b/, output.string)
      end
    end
  end
end
