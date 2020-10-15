class BasePresenter

  # Filters are used so we only have to display a specific metric
  DEFAULT_FILTERS = %w[visits unique_visits].freeze
  def initialize(metrics, filters: nil)
    @metrics = metrics
    @filters = filters || DEFAULT_FILTERS
  end

  def call
    raise NotImplementedError

  end

  private

  attr_reader :metrics, :filters
end