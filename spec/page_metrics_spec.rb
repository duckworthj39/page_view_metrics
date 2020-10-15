require 'spec_helper'
require 'page_metrics'


RSpec.describe PageMetrics do

  # Takes an array of logs and outputs an array of Page objects

  it 'returns an array of page objects' do
    logs = ['test/logs/path 000.000.000.000']
    metrics = PageMetrics.new(logs).call

    expect(metrics.first).to be_a(Page)
    expect(metrics.first.visits).to eq(1)
    expect(metrics.first.unique_visits).to eq(1)
  end

  it 'returns an array of page objects' do
    logs = File.open('spec/support/incorrect_data.log').read
    prepared_logs = logs.split("\n")

    expect{ PageMetrics.new(prepared_logs).call }.to raise_error(PageMetrics::WrongFormatError)
  end
end