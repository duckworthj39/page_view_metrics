# frozen_string_literal: true

require 'page_logs_loader'
RSpec.describe PageLogsLoader do
  let(:logs_path) { 'spec/support/test.log' }

  it 'loads the log file and returns the data as an array of objects' do
    logs = PageLogsLoader.new(file_path: logs_path).load_file

    expect(logs).to be_a(Array)
    expect(logs.first).to eq('test/log/path 000.000.000.000')
  end
end



