FactoryGirl.define do
  factory :location do
    latitude  { (90 * Random.rand) - 180 }
    longitude { (180 * Random.rand) - 360 }
  end
end
