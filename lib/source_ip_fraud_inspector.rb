module SourceIpFraudInspector
  def self.inspect(checkin)
    checkin.source.nil? || checkin.source.blank?
  end
end
