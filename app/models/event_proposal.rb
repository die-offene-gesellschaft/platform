class EventProposal < ApplicationRecord
  has_attached_file :logo,
                    styles: { normal: ['400x400^', :jpg],
                              large: ['800x800^', :jpg] }
  has_attached_file :picture,
                    styles: { normal: ['400x400^', :jpg],
                              large: ['800x800^', :jpg] }

  validates_attachment_content_type :logo,
                                    content_type: %r{\Aimage\/.*\z}
  validates_attachment_content_type :picture,
                                    content_type: %r{\Aimage\/.*\z}
  validates :logo,
            dimensions: { width: 500, height: 500 }
  validates :picture,
            dimensions: { width: 500, height: 500 }

  validates :title,
            :subject,
            :venue,
            :date,
            :organizer,
            :contact_person_forename,
            :contact_person_surname,
            :contact_person_mail,
            :symbol_for_open_society,
            :terms_of_use,
            presence: true

  validates :contact_person_mail,
            format: { with: /\A\S+@\S+\.\S+\z/ }
end
