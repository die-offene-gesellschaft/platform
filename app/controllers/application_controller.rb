class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_copyright_year
  before_action :set_title

  private

  def set_title
    @site_title = I18n.t('site-title.default')
    @site_title = I18n.t(
      'site-title.schema',
      title: @site_title,
      current_page: action_name.capitalize
    )
  end

  def set_copyright_year
    require 'date'
    @current_year = Time.zone.today.strftime('%Y')
  end
end
