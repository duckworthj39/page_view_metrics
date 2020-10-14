# frozen_string_literal: true

require 'parser'

RSpec.describe 'Page View metrics' do
  context '#parse_view_metrics' do
    let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

    it 'returns a list of most viewed in from most to least viwede order' do
      result = parse_view_metrics(integration_test_log_path)

      array_of_results = result.split('\n')
      expect(array_of_results.first).to eq('test/log/path/2 2 visits')
      expect(array_of_results.last).to eq('test/log/path 1 visits')
    end
  end
end
