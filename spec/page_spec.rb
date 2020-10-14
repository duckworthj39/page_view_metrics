# frozen_string_literal: true

require 'page'

RSpec.describe Page do

  subject { Page.new('test/path/1')}

  context 'with a single user' do
    it 'returns unique views' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')

      expect(subject.unique_visits).to eq(1)
    end
  end

  context 'with multiple users' do
    it 'increments the page views' do
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

    xit 'displays the metrics as a hash' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')

      hash = subject.to_h

      expect(hash).to eq({ address: 'test/path/1', unique_visits: 2, visits: 3})
    end
  end

  context 'visits attribute' do
    it 'displays a formatted string for a pages visits value' do
      subject.add_user('000.000.000.000')

      output = subject.visits_to_s

      expect(output).to eq('test/path/1 1 visit')

    end

    it 'displays a formatted string for a pages visits value with visits pluralised' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.000')

      output = subject.visits_to_s

      expect(output).to eq('test/path/1 2 visits')

    end
  end

  context 'unique visits attribute' do
    it 'displays a formatted string for a pages unique visits value' do
      subject.add_user('000.000.000.000')

      output = subject.unique_visits_to_s

      expect(output).to eq('test/path/1 1 unique visit')

    end

    it 'displays a formatted string for a pages unique visits value with visits pluralised' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')

      output = subject.unique_visits_to_s

      expect(output).to eq('test/path/1 2 unique visits')

    end
  end

  context 'table row' do
    it 'displays a coloured table rows' do
      subject.add_user('000.000.000.000')
      subject.add_user('000.000.000.001')

      output = subject.to_table_row

      expect(output).to eq("test/path/1 2 visits and 2 unique visits")
    end
  end
end