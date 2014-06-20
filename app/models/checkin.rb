class Checkin < ActiveRecord::Base
  include Napa::FilterByHash
  after_save :validate_checkin

  belongs_to :user
  validates :user, presence: true

  belongs_to :location
  validates :location, presence: true

  has_many :checkin_fraud_alerts

  validates_numericality_of :latitude,  allow_nil: true,
                                        greater_than_or_equal_to: -90,
                                        less_than_or_equal_to: 90

  validates_numericality_of :longitude, allow_nil: true,
                                        greater_than_or_equal_to: -180,
                                        less_than_or_equal_to: 180

  validate :both_geolocation_coordinates_must_be_provided

  scope :recent,      ->          { order(created_at: :desc) }
  scope :prior_to,    ->(time)    { where("created_at < ?", time) }
  scope :since,       ->(time)    { where("created_at > ?", time) }
  scope :for_user_id, ->(user_id) { where(user_id: user_id) }

  def self.time_since_last_checkin(user_id)
    return nil unless last_checkin = self.for_user_id(user_id).recent.first
    Time.now - last_checkin.created_at
  end

private
  def both_geolocation_coordinates_must_be_provided
    if (latitude.nil? ^ longitude.nil?)
      errors.add(:geolocation, "Must supply both latitude and longitude, or neither!")
    end
  end

  def validate_checkin
    CheckinFraudAlert.verify_checkin(self)
  end
end
