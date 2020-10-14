require 'spec_helper'
require 'page_metrics'


RSpec.describe PageMetrics do

  # Takes an array of logs and outputs an array of Page objects

  it 'returns an array of page objects' do
    logs = ['test/logs/path 000.000.000.000']
    metrics = PageMetrics.new(logs).call

    expect(metrics.first).to be_a(Page)
    expect(metrics.first.views).to eq(1)
    expect(metrics.first.unique_views).to eq(1)
  end
end