# frozen_string_literal: true

require 'colorize'

class MetricsPresenter
  def initialize(pages)
    @pages = pages
  end

  PERMITTED_METRIC_TYPE = %i[visits unique_visits].freeze

  def basic(metric_type:)
    raise NotImplementedError unless PERMITTED_METRIC_TYPE.include?(metric_type)

    header = metric_type.to_s.split('_').map(&:capitalize).join(' ')
    output = "#{header} \n"
    output += "---------- \n"
    append_metrics(output, metric_type)
  end

  def colourised_table
    output = "\n#{'Visits'.colorize(:light_yellow)} and #{'Unique Visits'.colorize(:light_red)} \n"
    output += "------------------------------------ \n"
    sorted_pages = pages.sort_by(&:to_table_row).reverse

    colour = :light_blue
    sorted_pages.each do |page|
      output += page.public_send('to_table_row').colorize(colour) + "\n"
      colour = alternate_colour(colour)
    end
    output
  end

  private

  attr_reader :pages

  def append_metrics(output, metric_type)
    sorted_pages = pages.sort_by(&metric_type).reverse
    sorted_pages.each do |page|
      output += page.public_send("#{metric_type}_to_s") + "\n"
    end
    output
  end

  def alternate_colour(colour)
    return :light_green if colour == :light_blue

    :light_blue
  end
end
