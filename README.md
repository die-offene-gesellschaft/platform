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
mysql -u offenege -p offenege < latest.sql
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

1. Create Issue
2. Assign yourself
3. Create feature branch with name pattern like `123-my-new-awesome-feature`, see `New branch` option in GitLab's issue detail view
4. Create merge request for feature branch in master
5. Let merge request be reviewed and accepted if applicable
