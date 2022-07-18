# frozen_string_literal: true

require 'active_record_query_stats/summary'

module ActiveRecordQueryStats
  class SqlEventAnalyzer
    def initialize(event)
      @event = event
    end

    def call
      return if skipping?

      increase_total
      return increase_cached if cached_query?

      increase_real
      increase_transaction_related || increase_statements || increase_other
    end

    private

    delegate :payload, to: :@event
    delegate(*Summary.instance_methods(false), to: :summary)

    def increase_transaction_related
      if rollback_query? then increase_rollback && increase_transaction
      elsif savepoint_query? then increase_savepoint && increase_transaction
      elsif transaction_query? then increase_transaction
      end
    end

    def increase_statements
      case payload[:sql]
      when /\s*SELECT .*FOR UPDATE\b/mi, /\A\s*LOCK\b/mi then increase_lock
      when /\A\s*SELECT/i then increase_select
      when /\A\s*INSERT/i then increase_insert
      when /\A\s*UPDATE/i then increase_update
      when /\A\s*DELETE/i then increase_delete
      end
    end

    def summary
      Summary.call
    end

    def skipping?
      schema_query? || schema_migration_query? || explain_query?
    end

    def schema_query?
      /SCHEMA/i =~ payload[:name]
    end

    def schema_migration_query?
      /schema_migrations/i =~ payload[:sql]
    end

    def explain_query?
      /EXPLAIN/i =~ payload[:name]
    end

    def cached_query?
      /CACHE/i =~ payload[:name] || payload[:cached]
    end

    def rollback_query?
      /\A\s*ROLLBACK/mi =~ payload[:sql]
    end

    def savepoint_query?
      /\A\s*(RELEASE )?SAVEPOINT/mi =~ payload[:sql]
    end

    def transaction_query?
      /TRANSACTION\s*\Z/i =~ payload[:sql] || /TRANSACTION/i =~ payload[:name]
    end
  end
end
