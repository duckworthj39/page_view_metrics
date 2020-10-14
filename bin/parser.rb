#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/page_logs_loader'
require_relative '../lib/page_metrics'
require_relative '../lib/metrics_presenter'

def parse_view_metrics(file_path: 'webserver.log')
  metrics_text = PageLogsLoader.new(file_path: file_path).load_file
  PageMetrics.new(metrics_text).call
end

def displayable_metrics(metrics:)
  visits_string = MetricsPresenter.new(metrics).call(metric_type: :visits)
  unique_visits = MetricsPresenter.new(metrics).call(metric_type: :unique_visits)

  visits_string + "\n\n" + unique_visits
end


log_file_path = ARGV[0] || 'webserver.log'
if File.exist?(log_file_path)
  puts "Reading logs from: #{log_file_path}\n\n"

  metrics = parse_view_metrics(file_path: log_file_path)
  puts displayable_metrics(metrics: metrics)
else
  puts 'file was not found, check your file path'
end






