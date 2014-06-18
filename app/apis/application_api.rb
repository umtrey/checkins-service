class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount CheckinsApi => '/checkins'

  add_swagger_documentation
end

