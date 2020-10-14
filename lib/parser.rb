# frozen_string_literal: true
require 'page_logs_loader'
require 'page_metrics'

def parse_view_metrics(file)
  metrics_text = PageLogsLoader.new(file_path: file).load_file
  metrics = PageMetrics.new(metrics_text).call
end



