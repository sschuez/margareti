module UploadsHelper
  def file_details_for(file)
    blob = ActiveStorage::Blob.find(file.blob_id)
    url = blob.attachments.any? ? rails_blob_path(file) : blob.url
    { filename: blob.filename,
      size: blob.byte_size,
      # content_type: blob.content_type,
      url: url,
      blob_id: blob.id
    }
  end
end