# frozen_string_literal: true

module ActiveRecordQueryStats
  # NOTE: by inheriting from `ActionController::LogSubscriber`,
  # it ensures to display the stats after the tranditional Rails stats
  # e.g. `Completed 204 No Content in 170ms (ActiveRecord: 80.1ms | Allocations: 72539)`
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
