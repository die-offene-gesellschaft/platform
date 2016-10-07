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
    @events = Event.where('end_at >= ?', Time.zone.now)
                   .where(planned: false)
                   .order(begin_at: :asc)
  end

  def set_users
    @users = User.where(locked: false)
                 .where.not(avatar_file_name: nil)
                 .limit(25)
                 .shuffle
  end
end
