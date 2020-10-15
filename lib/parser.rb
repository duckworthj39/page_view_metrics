
require 'page_logs_loader'
require 'page_metrics'
require 'metrics_presenter'

class Parser

  def initialize(loader: PageLogsLoader, page_metrics: PageMetrics, presenter: 'basic', output: $stdout)
    @loader = loader
    @page_metrics = page_metrics
    @presenter = presenter
    @output = output
  end

  def parse_file(file_path: 'webserver.log', formatting: 'basic')
    metrics_text = loader.new(file_path: file_path).load_file
    metric = page_metrics.new(metrics_text).call
    # metrics_presenter.new(metrics).public_send(formatting, metric_type: metric)
  end

  private

  attr_reader :loader, :page_metrics, :presenter

end