require 'page_logs_loader'

def parse_view_metrics(file)
  metrics_text = PageLogsLoader.new(file_path: file)
end
