class Blocks::BlocksController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @block = Block.new
    authorize @user
  end

  def create
    @block = Block.new(block_params)
    @user = User.find(params[:user_id])
    @block.user = @user
    authorize @block, policy_class: UserPolicy
    
    if @block.save
      respond_to do |format|
        format.html { redirect_to user_path(@user) }
        format.turbo_stream 
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @block = Block.find(params[:id])
    authorize @block, policy_class: UserPolicy
  end
  
  def update
    @block = Block.find(params[:id])
    authorize @block, policy_class: UserPolicy
    
    if @block.update(block_params)
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { flash.now[:notice] = "Block updated" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @block = Block.find(params[:id])
    authorize @block, policy_class: UserPolicy
    
    @block.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.turbo_stream { flash.now[:notice] = "Block deleted" }
    end
  end

  def order
    @block = Block.find(params[:id])
    authorize @block, :update?, policy_class: UserPolicy

    @block.insert_at(params[:new_position])

    head :no_content
  end

  private

  def block_params
    params.require(:block).permit(:name)
  end
end