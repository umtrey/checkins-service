class CheckinFraudAlert < ActiveRecord::Base
  belongs_to :checkin

  Types = {
    no_source_ip_address: 1,
    no_checkin_geolocation: 2,
    distance_to_location_exceeds_threshold: 3,
    distance_between_checkins_exceeds_threshold: 4
  }

  TypeInspectors = {
    no_source_ip_address: "SourceIpFraudInspector",
    no_checkin_geolocation: "CheckinGeolocationFraudInspector",
    distance_to_location_exceeds_threshold: "CheckinLocationDistanceFraudInspector",
    distance_between_checkins_exceeds_threshold: "CheckinProximityFraudInspector"
  }

  def self.verify_checkin(checkin)
    Types.each do |type, index|
      if Object.const_get(TypeInspectors[type]).send(:inspect, checkin)
        self.create(checkin: checkin, fraud_alert: index)
      end
    end

    return nil
  end
end
