# frozen_string_literal: true

require 'spec_helper'
require 'metrics_presenter'

RSpec.describe MetricsPresenter do
  context 'present visits' do
    it 'returns a simple presentable string with the most views' do
      page_double = double(visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visits')

      presenter_output = MetricsPresenter.new([page_double]).basic(metric_type: :visits)

      expect(presenter_output).to eq(
        "Visits \n---------- \ntest/path 1 visits\n"
      )
    end

    it 'returns a simple presentable string with the most views for multiple pages' do
      page_double = double(visits: 1, unique_visits: 1, visits_to_s: 'test/path 1 visits')
      page_double2 = double(visits: 1, unique_visits: 1, visits_to_s: 'test/path/2 1 visits')
      page_double3 = double(visits: 1, unique_visits: 1, visits_to_s: 'test/path/3 1 visits')

      presenter_output = MetricsPresenter
                         .new([page_double, page_double2, page_double3]).basic(metric_type: :visits)

      expect(presenter_output).to eq(
        "Visits \n---------- \ntest/path/3 1 visits\ntest/path/2 1 visits\ntest/path 1 visits\n"
      )
    end
  end

  context 'present unique visits' do
    it 'returns a simple presentable string with the most views' do
      page_double = double(visits: 1, unique_visits: 1, unique_visits_to_s: 'test/path 1 unique visits')

      presenter_output = MetricsPresenter
                         .new([page_double]).basic(metric_type: :unique_visits)

      expect(presenter_output).to eq(
        "Unique Visits \n---------- \ntest/path 1 unique visits\n"
      )
    end

    it 'returns a simple presentable string with the most views for multiple pages' do
      page_double = double(unique_visits: 2, unique_visits_to_s: 'test/path 2 unique visits')
      page_double2 = double(unique_visits: 3, unique_visits_to_s: 'test/path/2 3 unique visits')
      page_double3 = double(unique_visits: 1, unique_visits_to_s: 'test/path/3 1 unique visits')

      presenter_output = MetricsPresenter
                         .new([page_double, page_double2, page_double3]).basic(metric_type: :unique_visits)

      expect(presenter_output).to eq(
        "Unique Visits \n---------- \ntest/path/2 3 unique visits\ntest/path 2 unique visits\ntest/path/3 1 unique visits\n"
      )
    end
  end

  context '#colourful_table' do
    it 'displays a colourful table containing visits and unique visits' do
      page_double = double(to_table_row: 'test/path 1 visits')
      page_double2 = double(to_table_row: 'test/path/2 1 visits')
      page_double3 = double(to_table_row: 'test/path/3 1 visits')

      presenter_output = MetricsPresenter
                         .new([page_double, page_double2, page_double3]).colourised_table

      expect(presenter_output).to eq(
        "\n\e[0;93;49mVisits\e[0m and \e[0;91;49mUnique Visits\e[0m \n------------------------------------ \n\e[0;94;49mtest/path/3 1 visits\e[0m\n\e[0;92;49mtest/path/2 1 visits\e[0m\n\e[0;94;49mtest/path 1 visits\e[0m\n"
      )
    end
  end

  it 'raises a NotImplemented error if the metric_type is not in the permitted list' do
    page_double = double(visits: 1, unique_visits: 1)

    expect do
      MetricsPresenter.new([page_double]).basic(metric_type: 'test')
    end.to raise_error(NotImplementedError)
  end
end
