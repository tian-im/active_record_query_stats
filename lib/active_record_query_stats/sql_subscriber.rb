# frozen_string_literal: true

require 'active_record_query_stats/sql_event_analyzer'

module ActiveRecordQueryStats
  class SqlSubscriber < ActiveRecord::LogSubscriber
    def sql(event)
      SqlEventAnalyzer.new(event).call
    end
  end
end
