require 'presenters/base_presenter'


RSpec.describe BasePresenter do

  it 'displays NotImplementedError when a presenter is not implemented' do
    presenter = BasePresenter.new
    expect{ presenter.call }.to raise_error(NotImplementedError)
  end

end