# frozen_string_literal: true

require 'parser'

RSpec.describe 'Page View metrics' do

  let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

  context '#parse_file' do
    it 'parses the log file' do
      loader = spy(new: double(load_file: 'test_text'))
      page_metrics = spy
      metrics_presenter = spy

      parser = Parser.new(loader: loader, page_metrics: page_metrics, metrics_presenter: metrics_presenter)

      parser.parse_file

      expect(loader).to have_received(:new)
      expect(page_metrics).to have_received(:new)
      # expect(metrics_presenter).to have_received(:new)
    end
  end

  context 'integration specs' do
    it 'parses a log file and returns a basic output' do
      parser_output = Parser.new.parse_file(file_path: integration_test_log_path)

      expected_output_json = File.open('spec/support/output/displayable_metrics_output.json').read

      expected_output = JSON.parse(expected_output_json)["displayable_metrics_output"]

      expect(parser_output).to eq(expected_output)
    end

  end



  xcontext '#parse_view_metrics' do
    let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

    subject { described_class.new(file_path: integration_test_log_path)}

    it 'returns a list of Pages with metrics' do
      result = subject.call
      expect(result.first.visits).to eq(1)
      expect(result.first.unique_visits).to eq(1)
    end
  end

  xcontext '#displayable_metrics' do
    it 'returns a string of metrics that can be displayed' do
      expected_output_json = File.open('spec/support/output/displayable_metrics_output.json').read

      expected_output = JSON.parse(expected_output_json)["displayable_metrics_output"]
      metrics = parse_view_metrics(file_path: integration_test_log_path)

      result = display_metrics(metrics: metrics, formatting: :basic)

      expect(result).to eq(expected_output)
    end
  end
end
