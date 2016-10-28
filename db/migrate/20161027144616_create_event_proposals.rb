class CreateEventProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :event_proposals do |t|
      t.string :title
      t.text :subject
      t.string :venue
      t.string :date
      t.string :organizer
      t.string :contact_person_forename
      t.string :contact_person_surname
      t.string :contact_person_mail
      t.string :contact_person_phone
      t.string :participants
      t.text :symbol_for_open_society
      t.boolean :terms_of_use

      t.timestamps
    end
  end
end
