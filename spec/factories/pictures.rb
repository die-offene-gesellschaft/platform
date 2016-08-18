FactoryGirl.define do
  factory :picture do
    description 'Personal success is not wrong, but it is limited in importance, and once you have enough of it it is a shame to keep striving for that, instead of for truth, beauty, or justice.'
    taken_at { Time.zone.now }
    locked false
  end
end