# frozen_string_literal: true

module ActiveRecordQueryStats
  class Summary
    STATS = %i[
      total real cached
      select insert update delete
      transaction lock rollback other
    ].freeze

    def self.call
      RequestStore[:active_record_query_stats] ||= new
    end

    STATS.each do |field|
      define_method field do
        instance_variable_get(:"@#{field}") || 0
      end

      define_method :"increase_#{field}" do
        instance_variable_set :"@#{field}", try(field) + 1
      end
    end

    def to_payload
      STATS.each_with_object({}) do |field, memo|
        memo[field] = try field
      end
    end
  end
end
