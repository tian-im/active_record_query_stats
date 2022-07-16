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
      case payload[:sql]
      when /\A\s*rollback/mi then increase_rollback
      when /select .*for update/mi, /\A\s*lock/mi then increase_lock
      when /transaction\s*\Z/i then increase_transaction
      when /\A\s*(release )?savepoint/i then increase_savepoint
      end
    end

    def increase_statements
      case payload[:sql]
      when /\A\s*select/i then increase_select
      when /\A\s*insert/i then increase_insert
      when /\A\s*update/i then increase_update
      when /\A\s*delete/i then increase_delete
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
  end
end
