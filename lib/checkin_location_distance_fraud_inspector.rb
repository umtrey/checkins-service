module CheckinLocationDistanceFraudInspector
  MAXIMUM_DISTANCE_IN_KM = 1.0

  def self.inspect(checkin)
    return false if (checkin.latitude.nil? || checkin.longitude.nil?)
    return false if (checkin.latitude == 0 && checkin.longitude == 0)
    return false if (checkin.location.latitude.nil? || checkin.location.longitude.nil?)

    distance = Latitude.great_circle_distance(checkin.latitude,
                                              checkin.longitude,
                                              checkin.location.latitude,
                                              checkin.location.longitude)

    return (distance > MAXIMUM_DISTANCE_IN_KM)
  end
end
