# frozen_string_literal: true

require 'i18n'
require 'request_store'
require 'active_support'
require 'active_record/log_subscriber'
require 'action_controller'
require 'action_controller/log_subscriber'

require 'active_record_query_stats/sql_subscriber'
require 'active_record_query_stats/process_action_subscriber'

# This lib utilizes the Active Support Instrumentation system
# @see https://guides.rubyonrails.org/active_support_instrumentation.html
module ActiveRecordQueryStats
  # Setup I18n
  I18n.load_path += Dir[File.join(__dir__, 'locales', 'active_record_query_stats.en.yml')]
  I18n.reload! if I18n.backend.initialized?

  # @see https://guides.rubyonrails.org/active_support_instrumentation.html#sql-active-record
  SqlSubscriber.attach_to :active_record

  # @see https://guides.rubyonrails.org/active_support_instrumentation.html#process-action-action-controller
  ProcessActionSubscriber.attach_to :action_controller
end
