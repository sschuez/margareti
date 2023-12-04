class Users::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
