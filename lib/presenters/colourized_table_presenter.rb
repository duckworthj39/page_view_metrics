# frozen_string_literal: true

require_relative '../../lib/presenters/base_presenter'
require 'colorize'

class ColourizedTablePresenter < BasePresenter
  VISITS_HEADER = 'Visits'
  UNIQUE_VISITS_HEADER = 'Unique Visits'

  def call
    output = "\n#{VISITS_HEADER.colorize(:light_yellow)} and #{UNIQUE_VISITS_HEADER.colorize(:light_red)} \n"
    output += "------------------------------------ \n"
    sorted_metrics = metrics.sort_by(&:visits).reverse

    colour = :light_blue
    sorted_metrics.each do |metric|
      output += "| #{metric.address}"
      output += metric.public_send('to_table_row').colorize(colour) + "\n"
      colour = alternate_colour(colour)
    end
    output
  end

  private

  def alternate_colour(colour)
    return :light_green if colour == :light_blue

    :light_blue
  end
end
