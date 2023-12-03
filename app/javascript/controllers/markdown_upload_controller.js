import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"
import easyMDE from "easymde"

export default class extends Controller {
  static values = { 
    url: String,
    toolbar: Array
  }

  connect() {
    // Define a custom toolbar button for image uploads
    const uploadButton = {
      name: "upload-image",
      action: () => {
        this.triggerUploadDialog()
      },
      className: "fa fa-upload",
      title: "Upload Image",
    };

    // Include the upload button in your toolbar configuration
    const toolbar = this.toolbarValue ? [...this.toolbarValue, uploadButton] : [uploadButton];
    this.allowDropFileTypes = ["image/jpeg", "image/png", "image/gif"]
    this.easyMDE = new easyMDE({
      element: this.element,
      allowDropFileTypes: this.allowDropFileTypes,
      toolbar: toolbar
    })
    this.dropUpload()
    this.pasteUpload()
  }
  
  triggerUploadDialog() {
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = this.allowDropFileTypes.join(',');
    fileInput.style.display = 'none'; // Hide the file input

    fileInput.addEventListener('change', (event) => {
      this.uploadFiles(event.target.files);
      fileInput.remove(); // Clean up the file input from the DOM
    });

    document.body.appendChild(fileInput); // It needs to be in the DOM to be clickable
    fileInput.click(); // Trigger the file dialog
  }

  dropUpload() {
    this.easyMDE.codemirror.on("drop", (instance, event) => {
      event.preventDefault()
      this.uploadFiles(event.dataTransfer.files)
    })
  }

  pasteUpload() {
    this.easyMDE.codemirror.on("paste", (instance, event) => {
      if (!event.clipboardData.files.length) return;
      
      event.preventDefault()
      this.uploadFiles(event.clipboardData.files)
    })
  }

  uploadFiles(files) {
    Array.from(files).forEach(file => this.uploadFile(file))
  }

  uploadFile(file) {
    const upload = new DirectUpload(file, this.urlValue)

    upload.create((error, blob) => {
      if (error) {
        console.log("Error")
      } else {
        const text = this.markdownLink(blob)
        const cursorPosition = this.easyMDE.codemirror.getCursor()
        this.easyMDE.codemirror.replaceRange(text, cursorPosition)
      }
    })
  }

  markdownLink(blob) {
    const filename = blob.filename;
    const url = `/rails/active_storage/blobs/${blob.signed_id}/${filename}`
    const prefix = (this.isImage(blob.content_type) ? '!' : '')

    return `${prefix}[${filename}](${url})\n`
  }

  isImage(contentType) {
    return ["image/jpeg", "image/gif", "image/png"].includes(contentType)
  }

  disconnect() {
    this.easyMDE.toTextArea()
    this.easyMDE = null;
  }
}