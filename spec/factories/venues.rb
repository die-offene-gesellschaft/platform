FactoryGirl.define do
  factory :venue do
    name 'Berlin Congress Center'
    street 'Alexanderstraße 11'
    zip_code '10178'
    city 'Berlin'
    description 'Büros, Konferenz- und Veranstaltungsräume direkt am Alexanderplatz in Mitte.'
    locked false
    location { FactoryGirl.create(:location) }
  end
end
