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
cp "offenege-$timestamp".sql latest.sql
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

### Paperclip attachments

Copy all Paperclip attachements to your local machine.

```
rsync offenge@offenege.kochab.uberspace.de:~/offene-gesellschaft/public/system ./public/
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
3. Create feature branch with name pattern like `123-my-new-awesome-feature`
4. Create pull request for feature branch in master
5. Let merge request be reviewed and accepted if applicable
6. Results will be deployed to staging `dogtest.hamal.uberspace.de`
7. Add a version tag with the pattern `v1.2` to deploy to production `offenege.kochab.uberspace.de`
