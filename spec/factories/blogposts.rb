FactoryGirl.define do
  factory :blogpost do
    title "MyString"
    author "John Doe"
    blogpost_type "MyString"
    introduction "MyText"
    content "MyText"
    date Time.zone.now
  end
end
