# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersEditTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      user = FactoryBot.create :user
      get root_path

      watch_logger do |output|
        get edit_user_path(user)
        assert_response :success
        assert_match(/total: 1\b/, output.string)
        assert_match(/real: 1\b/, output.string)
      end
    end
  end
end
