FactoryGirl.define do
  factory :organizer do
    name 'Super organizer'
    url 'https://organize-it.example.com/awesome'
    logo { File.open("#{Rails.root}/spec/fixtures/images/test.jpg") }
  end
end
