require 'parser'


RSpec.describe 'Page View metrics' do
  context '#parse_view_metrics' do
    let(:integration_test_log_path) { 'spec/support/integration_test.log' }
    it 'returns a list displaying most viewed metrics from most viewed to least viewed' do
    
      result = parse_view_metrics(integration_test_log_path)

      expect(result).to include('test/log/path/2 2 visits')
    end
  end
 end
