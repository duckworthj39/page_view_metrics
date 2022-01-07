# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/presenters/basic_presenter'
require_relative '../support/shared_contexts/shared_metric_doubles'

RSpec.describe BasicPresenter do
  include_context('shared metric doubles')

  context 'without filter' do
    it 'returns a presentable string' do
      basic_presenter = described_class.new([metrics_double], filters: standard_filter).call

      expected_output = <<~OUTPUT
        \nVisits#{' '}
        ----------#{' '}
        test/path 1 visit

        Unique Visits#{' '}
        ----------#{' '}
        test/path 1 unique visit
      OUTPUT
      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string with multiple paths' do
      basic_presenter = described_class.new([metrics_double, metrics_double2], filters: standard_filter).call

      expected_output = <<~OUTPUT
        \nVisits#{' '}
        ----------#{' '}
        test/path/2 2 visits
        test/path 1 visit

        Unique Visits#{' '}
        ----------#{' '}
        test/path/2 3 unique visits
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end
  end

  context 'with filter' do
    it 'returns a presentable string for visits metric' do
      basic_presenter = described_class.new([metrics_double], filters: [:visits]).call

      expected_output = <<~OUTPUT

        Visits#{' '}
        ----------#{' '}
        test/path 1 visit
      OUTPUT
      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for unique visits metric' do
      basic_presenter = described_class.new([metrics_double], filters: [:unique_visits]).call

      expected_output = <<~OUTPUT
        \nUnique Visits#{' '}
        ----------#{' '}
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for visits metric with multiple paths' do
      basic_presenter = described_class.new([metrics_double, metrics_double2], filters: [:visits]).call

      expected_output = <<~OUTPUT
        \nVisits#{' '}
        ----------#{' '}
        test/path/2 2 visits
        test/path 1 visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end

    it 'returns a presentable string for multiple unique visits metrics' do
      basic_presenter = described_class.new([metrics_double, metrics_double2], filters: [:unique_visits]).call

      expected_output = <<~OUTPUT
        \nUnique Visits#{' '}
        ----------#{' '}
        test/path/2 3 unique visits
        test/path 1 unique visit
      OUTPUT

      expect(basic_presenter).to eq(expected_output)
    end
  end
end
