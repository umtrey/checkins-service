FactoryGirl.define do
  factory :checkin do |f|
    user
    location
    created_at Time.now
  end
end
