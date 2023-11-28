class Blocks::ItemsController < ApplicationController
  def new
    @block = Block.find(params[:block_id])
    @item = Item.new
  end

  def create
    @block = Block.find(params[:block_id])
    @item = Item.new(item_params)
    @item.block = @block

    if @item.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.turbo_stream { }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to user_path(current_user)
  end

  private

  def item_params
    params.require(:item).permit(:name, :content)
  end
end