# frozen_string_literal: true

require 'spec_helper'
require 'metrics_log_parser'

RSpec.describe MetricsLogParser do
  # Takes an array of logs and outputs an array of Page objects

  it 'returns an array of metric objects' do
    file_path = 'spec/support/integration_test_data.log'
    metrics = described_class.new(file_path).call

    expect(metrics.first).to be_a(Metric)
    expect(metrics.first.visits).to eq(1)
    expect(metrics.first.unique_visits).to eq(1)
  end

  it 'raises an error if the file is the wrong format' do
    file_path = 'spec/support/incorrect_data.log'

    expect { described_class.new(file_path).call }.to raise_error(MetricsLogParser::WrongFormatError)
  end

  it 'raises an error if the file does not exist' do
    file_path = 'does_not_exists'

    expect { described_class.new(file_path).call }.to raise_error('Log file not found')
  end
end
