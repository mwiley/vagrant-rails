# Vagrant Rails Development Box

Based off project: https://github.com/jackdb/pg-app-dev-vm

Includes Heroku's Cedar-14 stack and SQLite. The goal is getting your Rails app running in a virtual machine as fast as possible, and to deploy with no surprises.

* Ubuntu 14.04
* PostgreSQL 9.4
* SQLite
* NodeJS 0.10.25 (for ExecJS)
* Ruby (currently 2.1.5)
* Rubygems (currently 2.2.2)
* Imagemagick
* Phantomjs (for poltergeist gem)

To get started, clone this project.

```
$ git clone https://github.com/mwiley/vagrant-rails.git
```

This box is also available on [Atlas](https://atlas.hashicorp.com/mwiley/boxes/vagrant-rails). Using this method, you will have to manually add forwarded ports to your Vagrantfile, and download the Procfile and databases.yml files from this repository.

```
$ vagrant init mwiley/vagrant-rails
```

## Running a Rails app

```
$ vagrant up
$ vagrant ssh
$ rails new rails-test
$ cd rails-test
$ rails s -b 0.0.0.0
```

Navigate to [http://localhost:3000](http://localhost:3000) in your browser and you should see the default Rails page.

## Using PostgreSQL

SQLite is included for convenience, but you should configure PostgreSQL to keep consistent with the production environment.

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

## Using the Foreman gem
Foreman is a gem that executes your app in the same way it will be when deployed. More information is available [here](https://devcenter.heroku.com/articles/procfile#developing-locally-with-foreman).

Add the Puma gem to your Gemfile. This is the webserver that Heroku will use to run your app. The Procfile is included.

```ruby
source 'https://rubygems.org'
...
gem 'puma'
...

```

```
$ bundle
```

Start the server. As a bonus, this command is easier to type than 'rails s -b 0.0.0.0'.
```
$ foreman start
```

Foreman runs the webserver at [http://localhost:5000](http://localhost:5000).

Refer to [this page](https://devcenter.heroku.com/articles/getting-started-with-rails4#deploy-your-application-to-heroku) for instructions on how to deploy to Heroku.
