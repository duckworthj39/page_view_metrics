# frozen_string_literal: true

require 'metric'

RSpec.describe Metric do
  subject { described_class.new('test/path/1') }

  context 'with a single user' do
    it 'returns unique views' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')

      expect(subject.unique_visits).to eq(1)
    end
  end

  context 'with multiple users' do
    it 'increments visits' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')
      expect(subject.visits).to eq(2)
    end

    it 'returns unique views' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')

      expect(subject.unique_visits).to eq(2)
    end
  end

  context 'visits attribute' do
    it 'displays a formatted string for a metrics visits value' do
      subject.add_user('000.000.000.000')

      output = subject.visits_to_s

      expect(output).to eq('1 visit')
    end

    it 'pluralises visit when above 1' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')

      output = subject.visits_to_s

      expect(output).to eq('2 visits')
    end
  end

  context 'unique visits attribute' do
    it 'displays a formatted string for a pages unique visits value' do
      subject.add_user('000.000.000.000')

      output = subject.unique_visits_to_s

      expect(output).to eq('1 unique visit')
    end

    it 'pluralises unique visit when above 1' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')

      output = subject.unique_visits_to_s

      expect(output).to eq('2 unique visits')
    end
  end
end
