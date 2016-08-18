FactoryGirl.define do
  factory :comment do
    message 'No person, no idea, and no religion deserves to be illegal to insult, not even the Church of Emacs — and certainly not Islam.'
    locked false
    user { FactoryGirl.create(:user) }
    event { FactoryGirl.create(:event) }
  end
end
