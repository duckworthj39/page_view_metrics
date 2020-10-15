# frozen_string_literal: true

require_relative '../../lib/presenters/base_presenter'
require 'colorize'

class ColourizedTablePresenter < BasePresenter
  VISITS_HEADER = 'Visits'
  UNIQUE_VISITS_HEADER = 'Unique Visits'

  def call
    sorted_metrics = metrics.sort_by(&:visits).reverse

    colour = :light_blue
    output = ''
    sorted_metrics.each do |metric|
      output += "#{metric.address}"
      filters.each do |filter|
        output += "     #{metric.public_send("#{filter.to_sym}_to_s").colorize(colour)}"
        colour = alternate_colour(colour)
      end
      output += "\n"
    end
    output
  end

  private

  def alternate_colour(colour)
    return :light_green if colour == :light_blue

    :light_blue
  end
end
