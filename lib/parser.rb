# frozen_string_literal: true
require_relative 'page_logs_loader'
require_relative 'page_metrics'
require_relative 'metrics_presenter'

def parse_view_metrics(file: 'webserver.log')
  metrics_text = PageLogsLoader.new(file_path: file).load_file
  PageMetrics.new(metrics_text).call
end

def displayable_metrics(metrics:)
  visits_string = MetricsPresenter.new(metrics).call(metric_type: :visits)
  unique_visits = MetricsPresenter.new(metrics).call(metric_type: :unique_visits)

  visits_string + "\n\n" + unique_visits
end


metrics = parse_view_metrics
puts displayable_metrics(metrics: metrics)






