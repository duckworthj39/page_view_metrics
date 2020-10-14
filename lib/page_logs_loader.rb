# frozen_string_literal: true

class PageLogsLoader
  def initialize(file_path:)
    @file_path = file_path
  end

  def load_file
    log_data = File.open(file_path).read
    log_data.split("\n")
  end

  private

  attr_reader :file_path
end
