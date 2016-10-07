# Die offene Gesellschaft

This is the Ruby on Rails app powering the website of 'Die offene Gesellschaft'.

## Getting started

### Rails

Install Ruby in correct version.

```
rvm install ruby-2.3.1
rvm use ruby-2.3.1
```

Install gems.

```
bundle install
```

### Database

Create a new MySQL dump.

```
ssh offenge@offenege.kochab.uberspace.de
timestamp=`date +%Y-%m-%d-%H-%M-%S`
mysqldump offenege > offenege-"$timestamp".sql
cp "$timestamp".sql latest.sql
```

Copy the dump to your local machine.

```
rsync offenge@offenege.kochab.uberspace.de:~/latest.sql ./
```

Drop local database and read in dump.

```
rails db:drop
rails db:create
rails db:migrate
mysql -u offenege -p offenge < latest.sql
```

### Project

Start the server components.

```
foreman start
```

Open a Rails console and create an initial admin.

```
rails c
Admin.new(email: 'mail@example.com', password: '12345678').save!
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
