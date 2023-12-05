class Users::AttributesController < ApplicationController
  def edit
    @attribute = params[:attribute]
    @user = User.find(params[:user_id])
    authorize @user
  end

  def update
    @attribute = params[:attribute]
    @user = User.find(params[:user_id])
    authorize @user
    
    case @attribute
    when "full_name"
      @user.full_name = user_params[:full_name]
    when "bio"
      @user.bio = user_params[:bio]
    end
    
    if @user.save
      respond_to do |format|
        format.html { redirect_to user_path(@user), notice: "Your profile has been updated." }
        format.turbo_stream { flash.now[:notice] = "Your profile has been updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :bio)
  end
end
