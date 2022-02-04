# Fonix Chat

Simple web chat application using actioncable

## Installation

Clone the repo, then:

```
rvm install 3.0.0
gem install bundler
bundle install
yarn install
rails webpacker:install
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
