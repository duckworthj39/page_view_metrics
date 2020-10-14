
RSpec.describe MetricsPresenter do
  it 'returns a simple presentable string with the most views' do
    page_double = double(address: 'test/path', views: 1, unique_views: 1)

    presenter_output = MetricsPresenter.new([page_double]).call

    expect(presenter_output).to eq('test/path visits 1\n')
  end
end