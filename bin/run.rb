#!/usr/bin/env ruby
# frozen_string_literal: true

require 'parser'

PERMITTED_FORMATTING = %i[basic, colourful].freeze

log_file_path = ARGV[0] || 'webserver.log'
formatting = ARGV[1] || "basic"

puts "Reading logs from: #{log_file_path}\n\n"
if File.exist?(log_file_path)
  metrics = parse_view_metrics(file_path: log_file_path)
  puts display_metrics(metrics: metrics, formatting: formatting.to_sym)
else
  puts 'file was not found, check your file path'
end






