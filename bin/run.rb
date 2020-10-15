#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/parser'

Parser.new.parse_file(*ARGV)



