class Location < ActiveRecord::Base
  include Napa::FilterByHash

  has_many :checkins
end
