class AddLogoAndPictureToEventProposal < ActiveRecord::Migration[5.0]
  def change
    add_attachment :event_proposals, :logo
    add_attachment :event_proposals, :picture
  end
end
