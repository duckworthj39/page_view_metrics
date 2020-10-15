# frozen_string_literal: true

require 'spec_helper'
require 'colorize'
require_relative '../../lib/presenters/colourized_table_presenter'

RSpec.describe ColourizedTablePresenter do
    context 'without filter' do
    it 'returns a presentable for a single row' do
      metrics_double = double(
        address: 'test/path', visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      colourful_output = described_class.new([metrics_double]).call

      expected_output = <<~OUTPUT
        test/path     \e[0;94;49mtest/path 1 visit\e[0m     \e[0;92;49mtest/path 1 unique visit\e[0m
      OUTPUT
      expect(colourful_output).to eq(expected_output)
    end

    it 'returns a presentable for multiple rows' do
      metrics_double = double(
        address: 'test/path', visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      metrics_double2 = double(
        address: 'test/path/2', visits: 2, unique_visits: 2, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      colourful_output = described_class.new([metrics_double, metrics_double2]).call

      expected_output = <<~OUTPUT
        test/path/2     \e[0;94;49mtest/path 1 visit\e[0m     \e[0;92;49mtest/path 1 unique visit\e[0m
        test/path     \e[0;94;49mtest/path 1 visit\e[0m     \e[0;92;49mtest/path 1 unique visit\e[0m
      OUTPUT

      expect(colourful_output).to eq(expected_output)
    end
  end
end
