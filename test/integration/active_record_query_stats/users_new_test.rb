# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersNewTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      get root_path

      watch_logger do |output|
        get new_user_path
        assert_response :success
        assert_match(/total: 0\b/, output.string)
      end
    end
  end
end
