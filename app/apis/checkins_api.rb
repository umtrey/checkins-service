class CheckinsApi < Grape::API
  desc 'Create an checkin'
  params do
    requires :user_id, type: Integer, desc: "The ID of the user checking in"
    requires :location_id, type: Integer, desc: "The ID of the location the user is checking into"
  end

  post do
    checkin = Checkin.create(declared(params, include_missing: false))
    error!(present_error(:record_invalid, checkin.errors.full_messages)) unless checkin.errors.empty?
    represent checkin, with: CheckinRepresenter
  end

  params do
    requires :user_id, type: Integer, desc: "The ID of the user with checkins"
  end
  resource :user do
    route_param :user_id do
      desc 'Get user checkins'
      get do
        checkins = Checkin.where(user_id: params[:user_id])
        represent checkins, with: CheckinRepresenter
      end
    end
  end

  params do
    requires :location_id, type: Integer, desc: "The ID of the location users are checking in to"
  end
  resource :location do
    route_param :location_id do
      desc 'Get location checkins'
      get do
        checkins = Checkin.where(location_id: params[:location_id])
        represent checkins, with: CheckinRepresenter
      end
    end
  end

end
