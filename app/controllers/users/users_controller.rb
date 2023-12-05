class Users::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
