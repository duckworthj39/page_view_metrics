# frozen_string_literal: true

require 'parser'

RSpec.describe 'Page View metrics' do
  context '#parse_view_metrics' do
    let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

    it 'returns a list of Pages with metrics' do
      result = parse_view_metrics(integration_test_log_path)

      expect(result.first.views).to eq(1)
      expect(result.first.unique_views).to eq(1)
    end
  end
end
