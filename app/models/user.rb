class User < ActiveRecord::Base
  include Napa::FilterByHash

  has_many :checkins
end
