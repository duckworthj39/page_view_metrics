# frozen_string_literal: true

require_relative 'page'

# PageMetrics provides a method of returning a Hash of Pages which can be used to display the metrics
class PageMetrics

  class WrongFormatError < StandardError; end

  def initialize(log)
    @log = log
  end

  def call
    log.each_with_object({}) do |logged_page, pages|
      log_path, log_user = logged_page.split(' ')
      validate_logs(log_path, log_user)

      next pages[log_path].add_user(log_user) unless pages[log_path].nil?

      page = Page.new(log_path)
      page.add_user(log_user)
      pages[log_path] = page
    end.values
  end

  private

  attr_reader :log

  def validate_logs(log_path, log_user)
    raise WrongFormatError, 'log file cannot be parsed' if log_path.nil? || log_user.nil?
  end
end