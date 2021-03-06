class AvatarsController < ApplicationController
  respond_to :html
  before_action :authenticate_user
  attr_reader :current_user

  def show; end

  def create
    current_user.update(user_params)
    if current_user.valid?
      render :show
    else
      flash[:danger] = current_user.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  private

  def authenticate_user
    session['Authorization'] = params[:token] unless session['Authorization']
    @current_user = DecodeAuthenticationCommand.call(session).result

    raise NotAuthorizedException unless @current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :avatar_cache)
  end
end
