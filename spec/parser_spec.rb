# frozen_string_literal: true

require_relative '../bin/parser'

RSpec.describe 'Page View metrics' do

  let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

  context '#parse_view_metrics' do
    let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

    it 'returns a list of Pages with metrics' do
      result = parse_view_metrics(file_path: integration_test_log_path)
      expect(result.first.visits).to eq(1)
      expect(result.first.unique_visits).to eq(1)
    end
  end

  context '#displayable_metrics' do
    it 'returns a string of metrics that can be displayed' do
      expected_output_json = File.open('spec/support/output/displayable_metrics_output.json').read

      expected_output = JSON.parse(expected_output_json)["displayable_metrics_output"]
      metrics = parse_view_metrics(file_path: integration_test_log_path)

      result = displayable_metrics(metrics: metrics, formatting: :basic)

      expect(result).to eq(expected_output)
    end
  end
end
