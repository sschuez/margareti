class Blocks::BlocksController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @block = Block.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
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