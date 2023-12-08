class Blocks::ItemContentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
  def show
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy
  end

  def show_photo
    @item = Item.find(params[:id])
    authorize @item, :show?, policy_class: UserPolicy
    
    @photo = @item.photos.find(params[:photo_id])
  end

  def edit
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy
  end

  def update
    @item = Item.find(params[:id])
    authorize @item, policy_class: UserPolicy

    # Filter out non-existent blob IDs before updating the item
    filtered_params = item_params_with_existing_blobs

    if @item.update(filtered_params)
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
    params.require(:item).permit(:content, photos: [])
  end

# Filter out non-existent blob IDs
def item_params_with_existing_blobs
  params.require(:item).permit(:content, photos: []).tap do |filtered_params|
    if filtered_params[:photos]
      # Decode and filter blob_signed_ids to only include existing blobs
      existing_blob_signed_ids = filtered_params[:photos].select do |signed_id|
        next if signed_id.blank?
        blob_id = ActiveStorage.verifier.verify(signed_id, purpose: :blob_id)
        ActiveStorage::Blob.where(id: blob_id).exists?
      end

      # Replace the photos array with the filtered list of signed IDs
      filtered_params[:photos] = existing_blob_signed_ids
    end
  end
end
end