class AboutController < ApplicationController
  before_action :set_press_reviews

  private

  def set_press_reviews
    @press_reviews = []
  end
end
