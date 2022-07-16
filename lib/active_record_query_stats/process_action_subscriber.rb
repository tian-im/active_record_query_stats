# frozen_string_literal: true

module ActiveRecordQueryStats
  class ProcessActionSubscriber < ActionController::LogSubscriber
    def process_action(_event)
      debug color(stats_display, MAGENTA)
    end

    private

    def stats_display
      I18n.t 'active_record_query_stats.stats_template', **summary.to_payload
    end

    def summary
      Summary.call
    end
  end
end
