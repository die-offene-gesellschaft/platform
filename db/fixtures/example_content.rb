# user
user = User.seed(id: 1, email: 'og@example.com', password: '12345678').first

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
harald_welzer = ActiveMember.seed(id: 1, forename: 'Harald', surname: 'Welzer').first
joerg_armbruster = ActiveMember.seed(id: 2, forename: 'Jörg', surname: 'Armbruster').first
gritt_gruettner = ActiveMember.seed(id: 3, forename: 'Gritt', surname: 'Grüttner').first
wolfgang_kreuter = ActiveMember.seed(id: 4, forename: 'Wolfgang', surname: 'Kreuter').first

# events
Event.seed(:id,
  {
    id: 1,
    title: 'Schauspiel Stuttgart',
    event_type: 'Debatte',
    description: '',
    begin_at: DateTime.new(2016, 9, 5, 18),
    end_at: DateTime.new(2016, 9, 5, 21),
    locked: false,
    active_members: [harald_welzer, joerg_armbruster],
    user: user,
    venue: die_staatstheater_stuttgart
  },
  {
    id: 2,
    title: 'Hessisches Staatstheater Wiesbaden',
    event_type: 'Debatte',
    description: '',
    begin_at: DateTime.new(2016, 9, 14, 18),
    end_at: DateTime.new(2016, 9, 14, 21),
    locked: false,
    active_members: [gritt_gruettner, wolfgang_kreuter],
    user: user,
    venue: hessisches_staatstheater_wiesbaden
  },
  {
    id: 3,
    title: 'Deutsches Theater Göttingen',
    event_type: 'Debatte',
    description: '',
    begin_at: DateTime.new(2016, 9, 17, 18),
    end_at: DateTime.new(2016, 9, 17, 21),
    locked: false,
    active_members: [harald_welzer],
    user: user,
    venue: deutsches_theater_goettingen
  }
)
