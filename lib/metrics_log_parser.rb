# frozen_string_literal: true

require_relative 'metric'

# MetricsLogParser provides a method for returning an Array of Metrics which can be used to display the metrics
class MetricsLogParser
  class WrongFormatError < StandardError; end

  def initialize(file_path)
    @file_path = validate_file_path(file_path)
  end

  def call
    metrics = {}
    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        log_path, log_user = valid_logs(line)
        next metrics[log_path].add_user(log_user) unless metrics[log_path].nil?

        metrics[log_path] = create_metric(log_path, log_user)
      end
      metrics.values
    end
  end

  private

  attr_reader :file_path

  def valid_logs(line)
    log_path, log_user = line.split(' ')
    raise WrongFormatError, "#{file_path} file cannot be parsed" if log_path.nil? || log_user.nil?

    [log_path, log_user]
  end

  def validate_file_path(file_path)
    raise 'Log file not found' unless File.exist?(file_path)

    file_path
  end

  def create_metric(log_path, log_user)
    metric = Metric.new(log_path)
    metric.add_user(log_user)
    metric
  end
end
