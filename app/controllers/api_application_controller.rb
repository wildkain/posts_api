class ApiApplicationController < ActionController::API
  include TokenAuthentication
  respond_to :json
end