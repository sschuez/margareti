class Users::PhotosController < ApplicationController
  def edit
  end

  def update
    current_user.photo.attach(user_params[:photo])
    flash[:notice] = "Photo updated"
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(
      :photo
    )
  end
end
