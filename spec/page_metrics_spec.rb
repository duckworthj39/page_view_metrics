require 'spec_helper'
require 'page_metrics_processors/most_views'
require 'page_metrics'
require 'page_metrics/page_metrics_processors_spec'


RSpec.describe PageMetrics do

  # Takes an array of logs and outputs an array of Page objects

  it 'returns an array of page objects' do
    logs = ['test/logs/path 000.000.000.000']
    metrics = PageMetrics.new(logs).call

    expect(metrics["test/logs/path"]).to be_a(Page)
    expect(metrics["test/logs/path"].views).to eq(1)
    expect(metrics["test/logs/path"].unique_views).to eq(1)
  end
end