# frozen_string_literal: true

require 'spec_helper'
require 'page_metrics'

RSpec.describe PageMetrics do
  # Takes an array of logs and outputs an array of Page objects

  it 'returns an array of page objects' do
    file_path = 'spec/support/integration_test_data.log'
    metrics = described_class.new(file_path).call

    expect(metrics.first).to be_a(Metric)
    expect(metrics.first.visits).to eq(1)
    expect(metrics.first.unique_visits).to eq(1)
  end

  it 'returns an array of page objects' do
    file_path = 'spec/support/incorrect_data.log'

    expect { described_class.new(file_path).call }.to raise_error(PageMetrics::WrongFormatError)
  end
end
