# Checkins API

Super simple checkin service, built to play around with
[Napa](https://github.com/bellycard/napa).

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

Creates new checkin object.
