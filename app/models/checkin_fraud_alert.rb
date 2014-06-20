class CheckinFraudAlert < ActiveRecord::Base
  belongs_to :checkin

  Types = {
    no_source_ip_address: 1,
    no_checkin_geolocation: 2,
    distance_to_location_exceeds_threshold: 3,
    distance_between_checkins_exceeds_threshold: 4
  }
end
