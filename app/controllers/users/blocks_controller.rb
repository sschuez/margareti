class Users::BlocksController < ApplicationController
  def new
    @block = Block.new
  end

  def create
    @block = Block.new(block_params)
    @user = User.find(params[:user_id])
    @block.user = @user

    if @block.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to user_path(current_user)
  end

  private

  def block_params
    params.require(:block).permit(:name, :position)
  end
end