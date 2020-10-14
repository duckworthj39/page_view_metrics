# frozen_string_literal: true

class MetricsPresenter

  def initialize(pages)
    @pages = pages
  end

  PERMITTED_METRIC_TYPE = %i[visits unique_visits].freeze

  def call(metric_type:)
    raise NotImplementedError unless PERMITTED_METRIC_TYPE.include?(metric_type)

    header = metric_type.to_s.split('_').map(&:capitalize).join(' ')
    most_views_output = "#{header} \n"
    most_views_output += "---------- \n"

    sorted_pages = pages.sort_by(&:visits).reverse
    sorted_pages.each do |page|
      most_views_output += "#{page.address} #{page.public_send(metric_type)} #{header.downcase}\n"
    end
    most_views_output
  end

  private

  attr_reader :pages
end