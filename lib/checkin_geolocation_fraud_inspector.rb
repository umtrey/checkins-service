module CheckinGeolocationFraudInspector
  def self.inspect(checkin)
    (checkin.latitude.nil? && checkin.longitude.nil?) ||
      (checkin.latitude == 0 && checkin.longitude == 0)
  end
end
