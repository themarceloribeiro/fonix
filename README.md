# Fonix Chat

Simple web chat application using actioncable

## Installation

Clone the repo, then:

```
rvm install 3.0.2
rvm use 3.0.2
gem install bundler
bundle install
yarn install
```

NOTE: Be careful not to overwrite environment.js while running the next command:

```
rails webpacker:install
```

Database setup:

```
rake db:create
rake db:migrate
rake db:test:prepare
```

Start the server:

```
rails s
```

Once messages have been sent, you can start the sidekiq scheduler that will run once a week (every Monday 0am):

```
sidekiq -C config/sidekiq.yml
```

Or you could also trigger the worker via rails console:

```
rails c
WeeklyMailerBatchWorker.new.perform
```

To run specs:

```
rspec spec
```
