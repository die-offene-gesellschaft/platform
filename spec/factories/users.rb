FactoryGirl.define do
  factory :user do
    email 'john.doe@example.com'
    password '12345678'
    role 'OpenSource Software Evangelist'
    statement "I'd just like to interject for a moment. What you're referring to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux."
    locked false
  end
end
