class AddEventToPressReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :press_reviews, :event, index: true, foreign_key: true
  end
end
