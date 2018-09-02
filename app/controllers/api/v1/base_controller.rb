class BaseController < ActionController::API
  include TokenAuthentication
  respond_to :json
end