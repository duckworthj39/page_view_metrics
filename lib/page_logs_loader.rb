class PageLogsLoader 
  def initialize(file_path:)
    @file_path = file_path
  end

  def load_file
    log_file_text = File.open(file_path).read
    
  rescue LoadError => e
    puts e.message  
  end

  private 

  attr_reader :file_path
end
