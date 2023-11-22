ActiveSupport.on_load(:active_storage_attachment) do
  after_commit :after_attachment_commit_callback, on: [:create, :destroy]

  def after_attachment_commit_callback
    if record_type == "User" && name == "photo"
      user = User.find(record_id)
      user.broadcast_photo_change
    end
  end
end