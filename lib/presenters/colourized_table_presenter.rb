# frozen_string_literal: true

require_relative '../../lib/presenters/base_presenter'
require 'colorize'

# Provides a colourful side by side method of displaying the metrics in a terminal
class ColourizedTablePresenter < BasePresenter
  VISITS_HEADER = 'Visits'
  UNIQUE_VISITS_HEADER = 'Unique Visits'

  def call
    sorted_metrics = metrics.sort_by(&:visits).reverse
    output = ''
    sorted_metrics.each do |metric|
      output += metric.address
      output += append_columns(metric)
      output += "\n"
    end
    output
  end

  private

  def append_columns(metric)
    colour = :light_green
    filters.map do |filter|
      colour = alternate_colour(colour)
      "     #{metric.public_send("#{filter.to_sym}_to_s").colorize(colour)}"
    end.join('')
  end

  def alternate_colour(colour)
    return :light_green if colour == :light_blue

    :light_blue
  end
end
