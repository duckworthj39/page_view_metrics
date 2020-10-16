# frozen_string_literal: true

class BasePresenter
  # Filters are used so we only have to display a specific metric
  DEFAULT_FILTERS = %w[visits unique_visits].freeze
  def initialize(metrics, filters: DEFAULT_FILTERS)
    @metrics = metrics
    @filters = filters
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :metrics, :filters
end
