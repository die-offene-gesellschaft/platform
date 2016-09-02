class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_copyright_year
  before_action :set_title
  before_action :set_contents
  before_action :process_contents

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

  def set_contents
    @contents = Content.where(controller_action_name: "#{controller_name}##{action_name}")
                       .order(:order)
  end

  def process_contents
    @contents.each do |content|
      html = Kramdown::Document.new(content.value).to_html
      html.gsub!(/src="(.*)"/) do
        "src=\"#{ActionController::Base.helpers.asset_path("about#{Regexp.last_match[1]}")}\""
      end
      content.value = html
    end
    @content = ''
    @content = @contents.first.value if @contents.any?
  end
end
