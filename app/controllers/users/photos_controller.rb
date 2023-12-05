class Users::PhotosController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    authorize @user
  end

  def update
    @user = User.find(params[:user_id])
    authorize @user
    
    # Check if the `photo` param looks like a signed ID (contains Base64 data and a signature)
    if params.dig(:user, :photo) && 
        user_params[:photo].is_a?(String) && 
          user_params[:photo].match(/\A[^-]+--[^-]+\z/)
      @user.photo.attach(user_params[:photo])
    end

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
