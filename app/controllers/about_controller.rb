class AboutController < ApplicationController
  before_action :set_press_reviews

  private

  def set_press_reviews
    @press_reviews = PressReview.order(created_at: :desc).limit(10)
  end
end
