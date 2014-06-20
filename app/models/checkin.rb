class Checkin < ActiveRecord::Base
  include Napa::FilterByHash

  belongs_to :user
  validates :user, presence: true

  belongs_to :location
  validates :location, presence: true

  scope :recent,      ->          { order(created_at: :desc) }
  scope :for_user_id, ->(user_id) { where(user_id: user_id) }

  def self.time_since_last_checkin(user_id)
    return nil unless last_checkin = self.for_user_id(user_id).recent.first
    Time.now - last_checkin.created_at
  end
end
