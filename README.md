# Vagrant Rails Development Box

Based off project: https://github.com/jackdb/pg-app-dev-vm

Includes the Heroku Cedar-14 stack and SQLite for Rails development. The goal is making it as fast as possible to go from 'rails new' to running your app on a virtual machine and to deploy painlessly as
possible.

* Ubuntu 14.04
* PosgreSQL 9.4
* SQLite
* NodeJS 0.10.25 (for ExecJS)
* Ruby (currently 2.1.5)
* Rubygems (currently 2.2.2)
* Imagemagick
* Phantomjs (for poltergeist gem)

```
$ vagrant up
$ vagrant ssh
$ rails new rails-test
$ cd rails-test
$ rails s -b 0.0.0.0
```

Navigate to http://localhost:3000 in your browser and you should see the default Rails page. You must include the '-b 0.0.0.0' flag when starting the server.

## Using PostgreSQL

SQLite is included for convenience, but you should configure PostgreSQL to keep consistent with a production environment.

Add the gem to your Gemfile.

```ruby
source 'https://rubygems.org'
...
gem 'pg'
...

```

```
$ bundle
```

Overwrite the default config/databases.yml with the one provided.

```
$ cp config/pg_database.yml config/database.yml
```
