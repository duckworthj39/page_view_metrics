#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/parser'
require 'pry-nav'

Parser.new.parse_file(*ARGV)
