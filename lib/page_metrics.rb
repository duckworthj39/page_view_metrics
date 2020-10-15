# frozen_string_literal: true

require_relative 'metric'

# PageMetrics provides a method of returning a Hash of Pages which can be used to display the metrics
class PageMetrics
  class WrongFormatError < StandardError; end

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    metrics = {}
    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        log_path, log_user = line.split(' ')
        validate_logs(log_path, log_user)

        next metrics[log_path].add_user(log_user) unless metrics[log_path].nil?

        metric = Metric.new(log_path)
        metric.add_user(log_user)
        metrics[log_path] = metric
      end

      metrics.values
    end
  end

  private

  attr_reader :file_path

  def validate_logs(log_path, log_user)
    raise WrongFormatError, 'file_path file cannot be parsed' if log_path.nil? || log_user.nil?
  end
end
