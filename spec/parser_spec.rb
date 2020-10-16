# frozen_string_literal: true

require 'parser'

RSpec.describe Parser do
  let(:integration_test_log_path) { 'spec/support/integration_test_data.log' }

  context '#parse_file' do
    it 'parses the log file' do
      metrics_log_parser = spy
      output = spy

      parser = described_class.new(metrics_log_parser: metrics_log_parser, output: output)

      parser.parse_file

      expect(metrics_log_parser).to have_received(:new)
      expect(output).to have_received(:puts)
    end
  end

  context 'basic presentation' do
    it 'parses a log file and returns visits and unique visits' do
      output = spy
      described_class.new(output: output).parse_file(integration_test_log_path)
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['metrics_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end

    it 'parses a log file and returns visits metrics' do
      output = spy
      described_class.new(output: output).parse_file(integration_test_log_path, 'basic', 'visits')
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['visits_basic_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end

    it 'parses a log file and returns unique visits' do
      output = spy
      described_class.new(output: output).parse_file(integration_test_log_path, 'basic', 'unique_visits')
      expected_output_json = File.open('spec/support/output/parser_output.json').read
      expected_output = JSON.parse(expected_output_json)['unique_visits_basic_output']

      expect(output).to have_received(:puts) do |arg|
        expect(arg).to eq(expected_output)
      end
    end

    context 'colourized table' do
      it 'parses a log file and returns visits and unique visits' do
        output = spy
        described_class.new(output: output).parse_file(integration_test_log_path, 'colourized_table')
        expected_output_json = File.open('spec/support/output/parser_output.json').read
        expected_output = JSON.parse(expected_output_json)['colourized_table'].undump
        expect(output).to have_received(:puts) do |arg|
          expect(arg).to eq(expected_output)
        end
      end
    end

    context 'challange fixture' do
      let(:webserver_log) { 'spec/support/webserver.log' }
      it 'parses a log file and returns visits and unique visits' do
        output = spy

        described_class.new(output: output).parse_file(webserver_log)
        expected_output_json = File.open('spec/support/output/parser_output.json').read
        expected_output = JSON.parse(expected_output_json)['challenge_fixture']
        expect(output).to have_received(:puts) do |arg|
          expect(arg).to eq(expected_output)
        end
      end

    end
  end
end
