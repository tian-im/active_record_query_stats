# frozen_string_literal: true

require 'test_helper'

module ActiveRecordQueryStats
  class UsersDestroyTest < ActionDispatch::IntegrationTest
    include LoggerHelper

    def test_query_stats
      user = FactoryBot.create :user
      get root_path

      watch_logger do |output|
        delete user_path(user)
        assert_response :found
        assert_match(/total: 4\b/, output.string)
        assert_match(/real: 4\b/, output.string)
        assert_match(/select: 1\b/, output.string)
        assert_match(/delete: 1\b/, output.string)
        assert_match(/savepoint: 2\b/, output.string)
      end
    end
  end
end
