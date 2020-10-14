# frozen_string_literal: true

class Page

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

end