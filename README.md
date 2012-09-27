The simple test app with activerecord and grape as REST framework.

# Deployment Notes

## Engine Yard 

* Create account, point to GitHub repo (or any git server).
* Booting of 500 min free instance really slow 5 min+.
* SSH key for GitHub repo, and optional key for connecting to the server over SSH.
* Git repo server can be anywhere, but needs to support SSH.
* Mostly interaction with Engine Yard web interface.
    * Deploying of Git Ref default to HEAD.
    * rake db:migrate can be optionally used with the deployment.
* Postgres infered and created by including 'pg' gem in Gemfile.
    * The credentials used for db is unknown, unsure if it is using from database.yml
    * There is no interface for getting to the db.
    * By default is backing up db every 24 hours and keep them for 10 days.
* Uses Passenger 3 as App Server.
* Supports Ruby (jRuby), PHP and node.js
* Supports MySql, postgesql and mongodb databases.
* Domain DNS can be entered for app.

## Heroku

* Crete account, install gem heroku.
* In local folder (may or may not be existing git repo) run `heroku create`.
* Creates repo if there was none, to existing repo adds remote to the heroku git repo.
* Has its own Git server, but it can link only to GitHub.
* Interaction is mostly CLI based:
    * Deploying is by pushing
    * `heroku rake db:migrate`
* Postgres is default db.
    * Creates random db, user, pass, doesn't use database.yml.
    * There is a web interface for getting db details.
    * By default there is no backup, but there is an Add-on that can be attached.
    * postgres web interface has feature 'Data Clips', as queries that can be stored and executed.
* Supports Ruby, Python, Java, Scala. node.js, clojure.
* Supports postgresql and mongodb databases.
* Domain DNS can be entered for app.
    * Also available [jRuby support](http://carlhoerberg.github.com/blog/2012/03/29/run-jruby-on-heroku). 
* [Interesting reading](http://railsapps.github.com/rails-heroku-tutorial.html)
* [The Heroku Hacker's Guide](http://www.theherokuhackersguide.com) 10$ ebook, ultimate guide for deploying on Heroku.
