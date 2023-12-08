class FileUploadsController < ApplicationController
  skip_after_action :verify_authorized, only: :destroy
  
  def destroy
    return unless params[:id]
    
    blob = ActiveStorage::Blob.find(params[:id])
    
    if blob.attachments.any?
      user_attachment = blob.attachments.where(record_type: "User", name: "photo").last
      
      if user_attachment
        user = User.find(attachment.record_id)
      
        blob.attachments.each(&:purge_later)
        user.broadcast_photo_destroyed
      else
        blob.attachments.each(&:purge_later)
      end
    end
    
    blob.purge_later

    head :ok
  end
end