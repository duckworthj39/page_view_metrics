# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/presenters/basic_presenter'

RSpec.describe BasicPresenter do
  context 'without filter' do
    it 'returns a presentable string' do
      metrics_double = double(
        visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      basic_presenter = described_class.new([metrics_double]).call

      expected_output = <<~OUTPUT
        \nVisits 
        ---------- 
        test/path 1 visit

        Unique Visits 
        ---------- 
        test/path 1 unique visit
      OUTPUT
      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string with multiple paths' do
      metrics_double = double(
        visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visit', unique_visits_to_s: 'test/path 1 unique visit'
      )
      metrics_double2 = double(
        visits: 2, unique_visits: 3, visits_to_s: 'test/path/2 2 visit', unique_visits_to_s: 'test/path/2 3 unique visit'
      )
      basic_presenter = described_class.new([metrics_double, metrics_double2]).call

      expected_output = <<~OUTPUT
        \nVisits 
        ---------- 
        test/path/2 2 visit
        test/path 1 visit

        Unique Visits 
        ---------- 
        test/path/2 3 unique visit
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end
  end

  context 'with filter' do
    it 'returns a presentable string for visits metric' do
      metrics_double = double(
        visits: 1, visits_to_s: 'test/path 1 visit'
      )
      basic_presenter = described_class.new([metrics_double], filters: [:visits]).call

      expected_output = <<~OUTPUT

        Visits 
        ---------- 
        test/path 1 visit
      OUTPUT
      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for unique visits metric' do
      metrics_double = double(
        unique_visits: 1, unique_visits_to_s: 'test/path 1 unique visit'
      )
      basic_presenter = described_class.new([metrics_double], filters: [:unique_visits]).call

      expected_output = <<~OUTPUT
        \nUnique Visits 
        ---------- 
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for visits metric with multiple paths' do
      metrics_double = double(visits: 1, visits_to_s: 'test/path 1 visit')
      metrics_double2 = double(visits: 2, visits_to_s: 'test/path/2 2 visit')
      basic_presenter = described_class.new([metrics_double, metrics_double2], filters: [:visits]).call

      expected_output = <<~OUTPUT
        \nVisits 
        ---------- 
        test/path/2 2 visit
        test/path 1 visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for multiple unique visits metrics' do
      metrics_double = double(
        unique_visits: 1, unique_visits_to_s: 'test/path 1 unique visit'
      )
      metrics_double2 = double(
        unique_visits: 3, unique_visits_to_s: 'test/path/2 3 unique visit'
      )
      basic_presenter = described_class.new([metrics_double, metrics_double2], filters: [:unique_visits]).call

      expected_output = <<~OUTPUT
        \nUnique Visits 
        ---------- 
        test/path/2 3 unique visit
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output )
    end
  end
end
