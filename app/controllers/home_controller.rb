class HomeController < ApplicationController
  before_action :set_events, only: [:show]
  before_action :set_users, only: [:show]
  before_action :set_video_users, only: [:show]

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
                 .where(video_url: [nil, ''])
                 .where.not(avatar_file_name: nil)
                 .limit(25)
                 .shuffle
  end

  def set_video_users
    @video_users = User.where(locked: false)
                       .where.not(video_url: [nil, ''])
                       .where.not(avatar_file_name: nil)
                       .limit(2)
                       .shuffle
  end
end
