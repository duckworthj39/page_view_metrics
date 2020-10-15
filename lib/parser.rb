
require 'page_logs_loader'
require 'page_metrics'
require 'presenters/basic_presenter'
class Parser

  def initialize(loader: PageLogsLoader, page_metrics: PageMetrics, presenter: 'basic', output: $stdout)
    @loader = loader
    @page_metrics = page_metrics
    @presenter = presenter_class(presenter)
    @output = output
  end

  def parse_file(file_path: 'webserver.log', filters: nil)
    metrics_text = loader.new(file_path: file_path).load_file
    metrics = page_metrics.new(metrics_text).call

    output.puts presenter.new(metrics, filters: filters).call
  end

  private

  attr_reader :loader, :page_metrics, :presenter, :output

  def presenter_class(presenter_string)
    Object.const_get(
      "#{presenter_string.split('_').collect(&:capitalize).join}Presenter"
    )
  rescue NameError => e
    raise "#{presenter_string} presenter not found"
  end

end