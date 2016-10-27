FactoryGirl.define do
  factory :blogpost do
    title "MyString"
    blogpost_type "MyString"
    introduction "MyText"
    content "MyText"
    admin { FactoryGirl.create(:admin) }
    date Time.zone.now
  end
end
