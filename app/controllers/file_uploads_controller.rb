class FileUploadsController < ApplicationController
  # skip_after_action :verify_authorized, only: :destroy

  def destroy
    blob = ActiveStorage::Blob.find(params[:id])
    
    if blob.attachments.any?
      blob.attachments.where(record_type: "User", name: "photo").each do |attachment|
        user = User.find(attachment.record_id)
        respond_with_turbostream(user)
      end
      blob.attachments.each(&:purge_later) if blob.attachments.any?
    end
    
    blob.purge_later  
  end

  private

  def respond_with_turbostream(user)
    respond_to do |format|
      format.turbo_stream { render turbo_stream.replace("user_#{user.id}_photo", partial: "users/photos/photo", locals: { user: user, scroll_to: true }, target: "user_#{user.id}_photo"), flash.now[:notice] = "Photo removed" }
    end
  end
end