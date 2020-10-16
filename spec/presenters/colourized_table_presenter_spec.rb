# frozen_string_literal: true

require 'spec_helper'
require 'colorize'
require_relative '../../lib/presenters/colourized_table_presenter'
require_relative '../support/shared_contexts/shared_metric_doubles'

# When you see what looks like random values like this - \e[0;94;49m that is the colour code.
# this means when we do a puts it will colour the text, this is part of the colorize gem
RSpec.describe ColourizedTablePresenter do
  include_context('shared metric doubles')

  context 'without filter' do
    it 'returns a presentable for a single row' do
      colourful_output = described_class.new([metrics_double], filters: standard_filter).call

      expected_output = <<~OUTPUT
        test/path     \e[0;94;49m1 visit\e[0m     \e[0;92;49m1 unique visit\e[0m
      OUTPUT
      expect(colourful_output).to eq(expected_output)
    end

    it 'returns a presentable for multiple rows' do
      colourful_output = described_class.new([metrics_double, metrics_double2], filters: standard_filter).call

      expected_output = <<~OUTPUT
        test/path/2     \e[0;94;49m2 visits\e[0m     \e[0;92;49m3 unique visits\e[0m
        test/path     \e[0;94;49m1 visit\e[0m     \e[0;92;49m1 unique visit\e[0m
      OUTPUT

      expect(colourful_output).to eq(expected_output)
    end
  end
end
