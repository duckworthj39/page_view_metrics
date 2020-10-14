# frozen_string_literal: true

require 'page'

RSpec.describe Page do

  subject { Page.new('test/path/1')}

  context 'with a single user' do
    it 'increments the page views' do
      subject.add_user('000.000.000.000')
      expect(subject.users.count).to eq(1)
    end

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
      expect(subject.users.count).to eq(2)
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
end