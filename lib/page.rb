# frozen_string_literal: true

class Page

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
    "#{address} #{visits} visit#{visits > 1 ? "s" : ""}"
  end

  def unique_visits_to_s
    "#{address} #{unique_visits} unique visit#{unique_visits > 1 ? "s" : ""}"
  end

  def table_row_to_s
    "#{address} #{visits} visit#{visits > 1 ? "s" : ""} and #{unique_visits} unique visit#{unique_visits > 1 ? "s" : ""}"
  end

  private

  attr_reader :address, :users

end