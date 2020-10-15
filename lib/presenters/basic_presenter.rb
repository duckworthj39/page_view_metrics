require 'spec_helper'
require 'presenters/base_presenter'

class BasicPresenter < BasePresenter

  def call
    output = ''
    filters.each do |filter|
      header = filter.to_s.split('_').map(&:capitalize).join(' ')
      output += "\n#{header} \n"
      output += "---------- \n"
      output += append_metrics(filter)
    end

    output
  end

  private

  def append_metrics(filter)
    sorted_metrics = metrics.sort_by(&filter).reverse
    sorted_metrics.map do |metric|
      metric.public_send("#{filter}_to_s") + "\n"
    end.join('')
  end

end