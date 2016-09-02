class AboutController < ApplicationController
  before_action :set_markdown_partials, only: [:show]

  def show
  end

  private

  def set_markdown_partials
    require 'kramdown'
    @markdown_partials = {}
    %w(intro team partner press contact).each do |partial|
      markdown = File.read("#{Rails.root}/app/views/about/_#{partial}.md")
      html = Kramdown::Document.new(markdown).to_html
      html.gsub!(/src="(.*)"/) do
        "src=\"#{ActionController::Base.helpers.asset_path("about/#{$1}")}\""
      end
      @markdown_partials[partial] = html
    end
  end
end
