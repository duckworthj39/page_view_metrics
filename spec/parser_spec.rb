# frozen_string_literal: true

require 'parser'

RSpec.describe 'Page View metrics' do

  let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

  context '#parse_file' do
    it 'parses the log file' do
      loader = spy(new: double(load_file: 'test_text'))
      page_metrics = spy
      output = spy

      parser = Parser.new(loader: loader, page_metrics: page_metrics, output: output)

      parser.parse_file

      expect(loader).to have_received(:new)
      expect(page_metrics).to have_received(:new)
      expect(output).to have_received(:puts)
    end
  end

  context 'integration specs' do
    it 'parses a log file and returns a basic output' do
      output = spy
      Parser.new(output: output).parse_file(integration_test_log_path)
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['metrics_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end

    it 'parses a log file and returns a only visits as basic output' do
      output = spy
      Parser.new(output: output).parse_file(integration_test_log_path, 'basic', 'visits')
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['visits_basic_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end

    it 'parses a log file and returns a only unique visits as basic output' do
      output = spy
      Parser.new(output: output).parse_file(integration_test_log_path, 'basic', 'unique_visits')
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['unique_visits_basic_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end
  end
end
