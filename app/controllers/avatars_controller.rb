class AvatarsController < ApplicationController

  before_action :authenticate_user
  attr_reader :current_user

  def show
  end

  def create
    current_user.update(user_params)
    if current_user.valid?
      render :show
    else
      redirect_to root_path
    end
  end


  private

  def authenticate_user
    session["Authorization"] = "#{params[:token]}" if session["Authorization"].nil?
    @current_user =  DecodeAuthenticationCommand.call(session).result

    raise NotAuthorizedException unless @current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :avatar_cache)
  end
end
