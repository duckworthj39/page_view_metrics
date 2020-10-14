require 'page_metrics_processors/most_views'
require 'page'

class PageMetrics

  def initialize(log)
    @log = log
  end

  def call
    log.each_with_object({}) do |logged_page, pages|
      log_path, log_user = logged_page.split(" ")
      next pages[log_path].add_user(log_user) unless pages[log_path].nil?

      page = Page.new(log_path)

      page.add_user(log_user)
      pages[log_path] = page
    end
  end

  private

  attr_reader :log
end