FactoryGirl.define do
  factory :slide do
    link "MyString"
    text1 "MyText"
    text2 "MyText"
    picture { File.new("#{Rails.root}/spec/fixtures/images/test.jpg") }
    picture_updated_at "2016-11-22 16:17:24"
    slide_mode "text"
  end
end
