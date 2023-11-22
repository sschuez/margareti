class FileUploadsController < ApplicationController
  # skip_after_action :verify_authorized, only: :destroy

  def destroy
    return unless params[:id]
    
    blob = ActiveStorage::Blob.find(params[:id])
    
    if blob.attachments.any?
      attachment = blob.attachments.where(record_type: "User", name: "photo").last
      user = User.find(attachment.record_id)
      
      blob.attachments.each(&:purge_later)
      user.broadcast_photo_destroyed
    end
    
    blob.purge_later

    head :ok
  end
end