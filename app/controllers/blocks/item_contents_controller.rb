class Blocks::ItemContentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
  def show
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy
  end

  def edit
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy
  end

  def update
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy

    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to user_path(@item.block.user) }
        format.turbo_stream {flash.now[:notice] = "Item updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def save_content
    @item = Item.find(params[:id])
    authorize @item, :update?, policy_class: UserPolicy

    if @item.update(content: params[:content])
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Item content saved" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:content)
  end
end