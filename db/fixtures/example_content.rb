require 'rubygems'
require 'active_support/core_ext/date/conversions'

# user
user = User.seed(id: 1, email: 'og@example.com', password: '12345678').first
15.times do |i|
  User.seed(
    id: i + 2,
    email: Faker::Internet.email,
    password: '12345678',
    name: Faker::Name.name,
    statement: Faker::Hacker.say_something_smart,
    role: Faker::Name.title,
    avatar: File.new("#{Rails.root}/db/fixtures/pictures/user#{i + 1}.jpg"),
    locked: false
  )
end

# venues
die_staatstheater_stuttgart = Venue.seed(
  id: 1,
  name: 'Die Staatstheater Stuttgart',
  street: 'Oberer Schloßgarten 6',
  zip_code: 70173,
  city: 'Stuttgart',
  description: 'Das Stuttgarter Ballett, Staatstheater und die Oper Stuttgart zeigen auf zwei Bühnen klassische Produktionen.',
  locked: false,
  location: Location.seed(latitude: 48.7807241, longitude: 9.1832816, radius: 100.0).first
).first
hessisches_staatstheater_wiesbaden = Venue.seed(
  id: 2,
  name: 'Hessisches Staatstheater Wiesbaden',
  street: 'Christian-Zais-Straße 3',
  zip_code: 65189,
  city: 'Wiesbaden',
  description: 'Das traditionsreiche Theater zeigt Schauspiel, Opern, Premieren und Uraufführungen in einem prachtvollen Bau.',
  locked: false,
  location: Location.seed(latitude: 50.084219, longitude: 8.2435753, radius: 100.0).first
).first
deutsches_theater_goettingen = Venue.seed(
  id: 3,
  name: 'Deutsches Theater Göttingen',
  street: 'Theaterplatz 11',
  zip_code: 37073,
  city: 'Göttingen',
  description: 'Theaterinszenierungen im großen neoklassizistischen Saal sowie Lesungen und Song-Abende auf 2 kleinen Bühnen.',
  locked: false,
  location: Location.seed(latitude: 51.5364243, longitude: 9.9380753, radius: 100.0).first
).first

# active members
harald_welzer = ActiveMember.seed(id: 1, forename: 'Harald', surname: 'Welzer', role: Faker::Name.title).first
joerg_armbruster = ActiveMember.seed(id: 2, forename: 'Jörg', surname: 'Armbruster', role: Faker::Name.title).first
gritt_gruettner = ActiveMember.seed(id: 3, forename: 'Gritt', surname: 'Grüttner', role: Faker::Name.title).first
wolfgang_kreuter = ActiveMember.seed(id: 4, forename: 'Wolfgang', surname: 'Kreuter', role: Faker::Name.title).first

# events
Event.seed(:id,
  {
    id: 1,
    title: 'Schauspiel Stuttgart',
    event_type: 'Debatte',
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 7.days.from_now.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 7.days.from_now.change({ hour: 21, minute: 0, second: 0 }),
    locked: false,
    active_members: [harald_welzer, joerg_armbruster],
    user: user,
    venue: die_staatstheater_stuttgart
  },
  {
    id: 2,
    title: 'Hessisches Staatstheater Wiesbaden',
    event_type: 'Debatte',
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 14.days.from_now.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 14.days.from_now.change({ hour: 21, minute: 0, second: 0 }),
    locked: false,
    active_members: [gritt_gruettner, wolfgang_kreuter],
    user: user,
    venue: hessisches_staatstheater_wiesbaden
  },
  {
    id: 3,
    title: 'Deutsches Theater Göttingen',
    event_type: 'Debatte',
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 14.days.from_now.beginning_of_month.next_month.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 14.days.from_now.beginning_of_month.next_month.change({ hour: 18, minute: 0, second: 0 }),
    locked: false,
    active_members: [harald_welzer],
    user: user,
    venue: deutsches_theater_goettingen
  },
  {
    id: 4,
    title: 'Schauspiel Stuttgart',
    event_type: 'Debatte',
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 7.days.ago.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 7.days.ago.change({ hour: 21, minute: 0, second: 0 }),
    locked: false,
    active_members: [harald_welzer, joerg_armbruster],
    user: user,
    venue: die_staatstheater_stuttgart
  },
  {
    id: 5,
    title: 'Hessisches Staatstheater Wiesbaden',
    event_type: 'Debatte',
    picture: File.new("#{Rails.root}/db/fixtures/pictures/event.png"),
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 14.days.ago.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 14.days.ago.change({ hour: 21, minute: 0, second: 0 }),
    locked: false,
    active_members: [gritt_gruettner, wolfgang_kreuter],
    user: user,
    venue: hessisches_staatstheater_wiesbaden
  },
  {
    id: 6,
    title: 'Deutsches Theater Göttingen',
    event_type: 'Debatte',
    description: Faker::Lorem.sentences(5).join(' '),
    begin_at: 14.days.ago.beginning_of_year.prev_year.change({ hour: 18, minute: 0, second: 0 }),
    end_at: 14.days.ago.beginning_of_year.prev_year.change({ hour: 18, minute: 0, second: 0 }),
    locked: false,
    active_members: [harald_welzer],
    user: user,
    venue: deutsches_theater_goettingen
  }
)

# admin
admin = Admin.seed(:id,
  {
    id: 1,
    email: Faker::Internet.email,
    password: '12345678',
    name: Faker::Name.name
  }
).first

# blogposts
Blogpost.seed(:id,
  {
    id: 1,
    title: 'Mit uns in Aktion treten, ein Leitfaden',
    blogpost_type: 'article',
    introduction: Faker::Lorem.sentences(4).join(' '),
    content: Faker::Lorem.sentences(20).join(' '),
    hero: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    thumbnail: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    admin: admin
  },
  {
    id: 2,
    title: 'Fragen und Antworten',
    blogpost_type: 'article',
    introduction: Faker::Lorem.sentences(4).join(' '),
    content: Faker::Lorem.sentences(20).join(' '),
    hero: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    thumbnail: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    admin: admin,
    reference: Faker::Company.name
  },
  {
    id: 3,
    title: 'Der öffentliche Raum als Spielwiese für seine Bürger',
    blogpost_type: 'article',
    introduction: Faker::Lorem.sentences(4).join(' '),
    content: Faker::Lorem.sentences(20).join(' '),
    hero: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    thumbnail: File.new("#{Rails.root}/db/fixtures/pictures/blogpost-hero.jpg"),
    admin: admin
  }
)
