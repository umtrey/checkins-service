module CheckinProximityFraudInspector
  MAX_HOUR_TRAVEL = 150

  def self.inspect(checkin)
    return false if (checkin.latitude.nil? || checkin.longitude.nil?)
    return false if (checkin.latitude == 0 && checkin.longitude == 0)
    return false if (checkin.location.latitude.nil? || checkin.location.longitude.nil?)

    hour_checkins = Checkin.since(1.hour.ago).
                            prior_to(checkin.created_at).
                            for_user_id(checkin.user.id).
                            recent

    return false if hour_checkins.count == 0

    total_traveled = 0

    hour_checkins.each_with_index do |stop, index|
      previous_checkin = (index == 0 ? checkin : hour_checkins[index-1])
      distance = Latitude.great_circle_distance(hour_checkins[index].latitude,
                                                hour_checkins[index].longitude,
                                                previous_checkin.latitude,
                                                previous_checkin.longitude)
      total_traveled += distance
    end

    total_traveled > MAX_HOUR_TRAVEL
  end
end
