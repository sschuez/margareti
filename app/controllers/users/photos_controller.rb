class Users::PhotosController < ApplicationController
  def edit
  end

  def update
    @user = User.find(params[:user_id])
    @user.photo.attach(user_params[:photo])

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Photo updated" }
      format.html { redirect_to user_path(@user), notice: "Photo updated" }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :photo
    )
  end
end
