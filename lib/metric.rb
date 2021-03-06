# frozen_string_literal: true

# Model object for storing the line of a log, provides methods for displaying as a string
class Metric
  attr_reader :address, :users

  def initialize(address)
    @address = address
    @users = []
  end

  def add_user(user)
    users << user
  end

  def unique_visits
    users.uniq.count
  end

  def visits
    users.count
  end

  def visits_to_s
    "#{visits} visit#{visits > 1 ? 's' : ''}"
  end

  def unique_visits_to_s
    "#{unique_visits} unique visit#{unique_visits > 1 ? 's' : ''}"
  end
end
