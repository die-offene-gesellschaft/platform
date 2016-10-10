FactoryGirl.define do
  factory :user do
    email 'john.doe@example.com'
    password '12345678'
    role 'OpenSource Software Evangelist'
    statement "I'd just like to interject for a moment. What you're referring to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux."
    forename 'John'
    surname 'Doe'
    avatar { File.new("#{Rails.root}/spec/fixtures/images/test.jpg") }
    locked false
    newsletter true
    terms_of_use true

    factory :video_user do
      email 'video-dude@example.com'
      video_url 'https://www.youtube.com/watch?v=cDcBKVKQizg'
    end
  end
end
