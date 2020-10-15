# frozen_string_literal: true

require_relative 'page_logs_loader'
require_relative 'page_metrics'
require_relative '../lib/presenters/base_presenter'
require_relative '../lib/presenters/basic_presenter'

PERMITTED_FORMATS = %w[basic].freeze
PERMITTED_FILTERS = %w[visits unique_visits].freeze
class Parser
  def initialize(loader: PageLogsLoader, page_metrics: PageMetrics, output: $stdout)
    @loader = loader
    @page_metrics = page_metrics
    @output = output
  end

  # Filters can be passed as a string like so "visits unique_visits"
  # and will be converted to an array to be used for filtering
  def parse_file(file_path = 'webserver.log', format = 'basic', filters = nil)
    metrics_text = loader.new(file_path: file_path).load_file
    metrics = page_metrics.new(metrics_text).call

    presenter = presenter_class(validate_format(format))
    output.puts presenter.new(metrics, filters: validate_filters(filters)).call
  end

  private

  attr_reader :loader, :page_metrics, :presenter, :output

  def presenter_class(presenter_string)
    Object.const_get(
      "#{presenter_string.split('_').collect(&:capitalize).join}Presenter"
    )
  rescue NameError
    raise "#{presenter_string} presenter not found"
  end

  def validate_filters(filters)
    return if filters.nil?

    filter_array = filters.split(' ')
    raise 'Invalid Filter' unless filter_array.all? { |filter| PERMITTED_FILTERS.include?(filter) }

    filter_array
  end

  def validate_format(format)
    raise 'Invalid Format' unless PERMITTED_FORMATS.include?(format)

    format
  end
end
