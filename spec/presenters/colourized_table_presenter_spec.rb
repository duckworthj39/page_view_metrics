# frozen_string_literal: true

require 'spec_helper'
require 'colorize'
require_relative '../../lib/presenters/colourized_table_presenter'

RSpec.describe ColourizedTablePresenter do
  xcontext 'without filter' do
    it 'returns a presentable string' do
      metrics_double = double(
        visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )

      basic_presenter = described_class.new([metrics_double]).call


      expect(basic_presenter).to eq(
        "\nVisits \n---------- \ntest/path 1 visit\n\nUnique Visits \n---------- \ntest/path 1 unique visit\n"
      )
    end

    it 'returns a presentable string with multiple paths' do
      metrics_double = double(
        visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      metrics_double2 = double(
        visits: 2, unique_visits: 3, visits_to_s: 'test/path/2 2 visit', unique_visits_to_s: 'test/path/2 3 unique visit'
      )
      basic_presenter = described_class.new([metrics_double, metrics_double2]).call

      expect(basic_presenter).to eq(
        "\nVisits \n---------- \ntest/path/2 2 visit\ntest/path 1 visit\n\nUnique Visits \n---------- \ntest/path/2 3 unique visit\ntest/path 1 unique visit\n"
      )
    end
  end
end
