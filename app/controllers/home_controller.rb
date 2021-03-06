class HomeController < ApplicationController
  before_action :set_events, only: [:show]

  before_action :set_frontpage_users, only: [:show]
  before_action :set_video_users, only: [:show]
  before_action :set_vip_users, only: [:show]
  before_action :set_users, only: [:show]
  before_action :set_blogposts, only: [:show]
  before_action :set_slides, only: [:show]

  USERS_COUNT = 10
  FRONTPAGE_USERS_COUNT = 4
  VIDEO_USERS_COUNT = 2
  VIP_USERS_COUNT = 8
  EVENTS_COUNT = 9
  BLOGPOSTS_COUNT = 1

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
                   .limit(EVENTS_COUNT)
  end

  def set_blogposts
    @blogposts = Blogpost.where(published: true)
                         .sample(BLOGPOSTS_COUNT)
  end

  def set_frontpage_users
    @frontpage_users = User.where(locked: false)
                           .where(frontpage: true)
                           .where.not(avatar_file_name: nil)
                           .sample(FRONTPAGE_USERS_COUNT)
  end

  def set_video_users
    @video_users = User.where(locked: false)
                       .where.not(video_url: [nil, ''])
                       .where.not(avatar_file_name: nil)
                       .where.not(
                         id: @frontpage_users.map(&:id)
                       )
                       .sample(VIDEO_USERS_COUNT)
  end

  def set_vip_users
    @vip_users = User.where(locked: false)
                     .where(vip: true)
                     .where(video_url: [nil, ''])
                     .where.not(avatar_file_name: nil)
                     .where.not(
                       id: @frontpage_users.map(&:id) +
                           @video_users.map(&:id)
                     )
                     .sample(VIP_USERS_COUNT)
  end

  def set_users
    @users = User.where(locked: false)
                 .where.not(avatar_file_name: nil)
                 .where(video_url: [nil, ''])
                 .where.not(
                   id: @video_users.map(&:id) +
                       @frontpage_users.map(&:id) +
                       @vip_users.map(&:id)
                 )
                 .order(created_at: :desc)
                 .limit(USERS_COUNT)
  end

  def set_slides
    @slides = Slide.all.order(order: :asc)
  end
end
