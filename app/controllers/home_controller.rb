class HomeController < ApplicationController
  before_action :set_events, only: [:show]
  before_action :set_users, only: [:show]

  def show
    @contents = [
      Content.find_by(key: 'guideline'),
      Content.find_by(key: 'faciliation')
    ]
  end

  private

  def set_events
    @events = Event.all
  end

  def set_users
    @users = User.where(locked: false)
                 .where(terms_of_use: true)
                 .where.not(avatar_file_name: nil)
                 .order(created_at: :desc)
                 .limit(25)
  end
end
