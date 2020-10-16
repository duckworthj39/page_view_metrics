# frozen_string_literal: true

require_relative 'metrics_log_parser'
require_relative '../lib/presenters/base_presenter'
require_relative '../lib/presenters/basic_presenter'
require_relative '../lib/presenters/colourized_table_presenter'

PERMITTED_FORMATS = %w[basic colourized_table].freeze
PERMITTED_FILTERS = %w[visits unique_visits].freeze
class Parser
  def initialize(metrics_log_parser: MetricsLogParser, output: $stdout)
    @loader = loader
    @metrics_log_parser = metrics_log_parser
    @output = output
  end

  # Filters can be passed as a string  "visits unique_visits"
  # and will be converted to an array to be used for filtering
  def parse_file(file_path = 'webserver.log', format = 'basic', filters = nil)
    metrics = metrics_log_parser.new(file_path).call

    presenter = presenter_class(validate_format(format))
    output.puts presenter.new(metrics, filters: validate_filters(filters)).call
  end

  private

  attr_reader :loader, :metrics_log_parser, :presenter, :output

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
