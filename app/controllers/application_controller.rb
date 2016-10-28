class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_copyright_year
  before_action :set_title
  before_action :set_content_key
  before_action :set_contents
  before_action :set_pop_up
  before_action :process_contents, except: [:content_edit, :content_update]
  before_action :authenticate_admin!, only: [:content_edit]

  def content_edit
    render 'contents/edit'
  end

  def content_update
    @contents.each do |content|
      content.value = params[:contents][content.key]
      content.save!
    end
    flash[:success] = t('contents.update.success')
    redirect_to contents_path
  end

  private

  def set_title
    @site_title = I18n.t('site-title.default')
    current_page = translate "site-title.controller.#{controller_name}"
    current_page = translate "site-title.action.#{action_name}" unless current_page
    @site_title = I18n.t(
      'site-title.schema',
      title: I18n.t('site-title.default'),
      current_page: current_page
    ) if current_page
  end

  # this method smells of :reek:UtilityFunction
  def translate(key)
    I18n.t key,
           raise: true
  rescue
    nil
  end

  def set_copyright_year
    require 'date'
    @current_year = Time.zone.today.strftime('%Y')
  end

  def set_content_key
    @content_key = request.path[%r{\/(\w+)\/edit}, 1] || request.path[%r{\/(\w+)}, 1]
  end

  def set_contents
    @contents = Content.from_controller_action_or_key controller_name: controller_name,
                                                      action_name: action_name,
                                                      content_key: @content_key
  end

  def set_pop_up
    content = Content.find_by key: 'pop-up'
    return @pop_up = {
      title: '',
      text: ''
    } unless content

    html_content = Kramdown::Document.new(content.value).to_html.tr("\n", ' ')
    %r{<h1.*>(?<title>.+)<\/h1>.*<p>(?<text>.+)<\/p>} =~ html_content
    @pop_up = {
      title: title,
      text: text
    }
  end

  def process_contents
    @contents.each do |content|
      html = Kramdown::Document.new(content.value).to_html
      content.value = html
    end
    @content = ''
    @content = @contents.first.value if @contents.any?
  end
end
