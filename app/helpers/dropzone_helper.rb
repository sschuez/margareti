module DropzoneHelper
  def dropzone_controller_div(max_files = 4)
    data = {
      controller: "dropzone",
      'dropzone-max-file-size'=>"10",
      'dropzone-max-files' => "#{max_files}",
      'dropzone-accepted-files' => 'image/jpeg,image/jpg,image/png,image/gif',
      'dropzone-dict-file-too-big' => "Your file ({{filesize}} MB) is larger than allowed ({{maxFilesize}} MB)",
      'dropzone-dict-invalid-file-type' => "Invalid file type. Only jpg, .png or .gif are allowed",
    }
      
    content_tag :div, class: 'dropzone dropzone-default dz-clickable', data: data do
      yield
    end
  end
end