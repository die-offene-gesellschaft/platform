FactoryGirl.define do
  factory :event do
    title 'GNU+Linux Talk'
    event_type 'Talk'
    active_members 'Richard Stallman, Linus Torvalds, Greg Hartman, Bruce Schneier, Moxie Marlinspike'
    description 'It is unfortunate that he still has nonfree software in his computer. He needs to defenestrate it (which means, either throw Windows out of the computer or throw the computer out of the window). '
    begin_at { Time.zone.now }
    end_at { Time.zone.now + 2.hours }
    locked false
  end
end
