FactoryGirl.define do
  factory :picture do
    description 'Personal success is not wrong, but it is limited in importance, and once you have enough of it it is a shame to keep striving for that, instead of for truth, beauty, or justice.'
    taken_at { Time.zone.now }
    picture { File.new("#{Rails.root}/spec/fixtures/images/test.jpg") }
    locked false
    user { FactoryGirl.create(:user) }
    event { FactoryGirl.create(:event) }
  end
end
