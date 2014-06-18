class CheckinsApi < Grape::API
  desc 'Create an checkin'
  params do
    requires :user_id, type: Integer
    requires :location_id, type: Integer
  end

  post do
    checkin = Checkin.create(declared(params, include_missing: false))
    error!(present_error(:record_invalid, checkin.errors.full_messages)) unless checkin.errors.empty?
    represent checkin, with: CheckinRepresenter
  end
end
