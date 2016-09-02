FactoryGirl.define do
  factory :content do
    controller_action_name 'application#imprint'
    key "imprint"
    value "# Imprint\nThis is imprint"
    order 1
  end
end
