# frozen_string_literal: true

require 'presenters/base_presenter'

RSpec.describe BasePresenter do
  it 'displays NotImplementedError when a presenter is not implemented' do
    presenter = described_class.new('test_metrics')
    expect { presenter.call }.to raise_error(NotImplementedError)
  end
end
