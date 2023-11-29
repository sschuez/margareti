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
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.turbo_stream 
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @block = Block.find(params[:id])
    @block.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.turbo_stream { flash.now[:notice] = "Block deleted" }
    end
  end

  private

  def block_params
    params.require(:block).permit(:name, :position)
  end
end