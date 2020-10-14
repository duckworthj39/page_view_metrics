require 'spec_helper'
require 'metrics_presenter'

RSpec.describe MetricsPresenter do

  context 'present visits' do
    it 'returns a simple presentable string with the most views' do
      page_double = double(address: 'test/path', visits: 1, unique_visits: 1)

      presenter_output = MetricsPresenter.new([page_double]).call(metric_type: :visits)

      expect(presenter_output).to eq("Visits \n---------- \ntest/path 1 visits\n")
    end

    it 'returns a simple presentable string with the most views for multiple pages' do
      page_double = double(address: 'test/path', visits: 1, unique_visits: 1)
      page_double2 = double(address: 'test/path/2', visits: 1, unique_visits: 1)
      page_double3 = double(address: 'test/path/3', visits: 1, unique_visits: 1)

      presenter_output = MetricsPresenter.new([page_double, page_double2, page_double3]).call(metric_type: :visits)

      expect(presenter_output).to eq("Visits \n---------- \ntest/path/3 1 visits\ntest/path/2 1 visits\ntest/path 1 visits\n")
    end
  end

  context 'present unique visits' do
    it 'returns a simple presentable string with the most views' do
      page_double = double(address: 'test/path', visits: 1, unique_visits: 1)

      presenter_output = MetricsPresenter.new([page_double]).call(metric_type: :unique_visits)

      expect(presenter_output).to eq("Unique Visits \n---------- \ntest/path 1 unique visits\n")
    end

    it 'returns a simple presentable string with the most views for multiple pages' do
      page_double = double(address: 'test/path', visits: 2, unique_visits: 2)
      page_double2 = double(address: 'test/path/2', visits: 3, unique_visits: 3)
      page_double3 = double(address: 'test/path/3', visits: 1, unique_visits: 1)

      presenter_output = MetricsPresenter.new([page_double, page_double2, page_double3]).call(metric_type: :unique_visits)

      expect(presenter_output).to eq("Unique Visits \n---------- \ntest/path/2 3 unique visits\ntest/path 2 unique visits\ntest/path/3 1 unique visits\n")
    end
  end

  it 'raises a NotImplemented error if the metric_type is not in the permitted list' do
    page_double = double(address: 'test/path', visits: 1, unique_visits: 1)

    expect{ MetricsPresenter.new([page_double]).call(metric_type: 'test') }.to raise_error(NotImplementedError)
  end
end