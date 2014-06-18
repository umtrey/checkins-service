class CheckinRepresenter < Napa::Representer
  property :id,          type: Integer
  property :user_id,     type: Integer
  property :location_id, type: Integer
  property :created_at,  type: DateTime
end
