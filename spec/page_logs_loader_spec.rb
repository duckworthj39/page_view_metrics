


RSpec.describe PageLogsLoader do

  let(:logs_path) { 'spec/support/test.log' }

  it 'loads the log file and returns an array of objects' do
    logs_text = PageLogsLoader.new(file_path: logs_path).load_file

    expect(logs_text).to include('test/log/path 000.000.000.000')
  end
end



