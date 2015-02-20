# Vagrant Rails Development Box

Based off project: https://github.com/jackdb/pg-app-dev-vm

Includes the Heroku Cedar-14 stack and SQLite for Rails development. The goal is making it as fast as possible to go from 'rails new' to running your app on a virtual machine.

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

Navigate to localhost:3000 in your browser and you should see the default Rails page.
