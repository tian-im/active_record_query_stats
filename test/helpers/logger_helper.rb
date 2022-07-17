# frozen_string_literal: true

module LoggerHelper
  def watch_logger(&block)
    origin = ActionController::Base.logger
    string_output = StringIO.new
    begin
      ActionController::Base.logger = ActiveSupport::Logger.new(string_output)
      block.call(string_output)
    ensure
      ActionController::Base.logger = origin
    end
  end
end
