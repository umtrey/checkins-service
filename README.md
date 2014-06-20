# Checkins API

Super simple checkin service, built to play around with
[Napa](https://github.com/bellycard/napa).

i[![Build
Status](https://travis-ci.org/umtrey/checkins-service.svg)](https://travis-ci.org/umtrey/checkins-service)

## Getting Started

```
git clone https://github.com/umtrey/checkins-service.git
cd checkins-service
bundle install
bundle exec rake db:reset
RACK_ENV=test bundle exec rake db:reset
```

Then make sure the tests are all passing with `bundle exec rspec spec/`.

## API Endpoints

The following API endpoints are implemented.

### POST /checkins

Requires: `user_id`, `location_id`

Creates a new checkin for the given user at the given location.

Note: user_id and location_id must have corresponding users and
locations in the database. Hypothetically, another service would be
managing these objects as represented in the database.

### GET /checkins/user/:user_id

Requires: n/a

Retrieves all checkins for the given user.

### GET /checkins/location/:location_id

Requires: n/a

Retrieves all checkins for the given location.
