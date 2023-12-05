import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"
import { put } from "@rails/request.js"
import easyMDE from "easymde"

export default class extends Controller {
  static values = { 
    url: String,
    updateUrl: String,
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
    }

    // Define a custom toolbar button for saving the content
    const saveButton = {
      name: "save",
      action: () => {
        this.saveContent();
      },
      className: "fa fa-save",
      title: "Save Content (Cmd/Ctrl+S)",
      hotkey: 'Cmd-S'
    }

    // Include the save button in your toolbar configuration
    const toolbar = this.toolbarValue ? [...this.toolbarValue, uploadButton, saveButton] : [uploadButton, saveButton]
    
    this.allowDropFileTypes = ["image/jpeg", "image/png", "image/gif"]
    this.easyMDE = new easyMDE({
      element: this.element,
      allowDropFileTypes: this.allowDropFileTypes,
      toolbar: toolbar
    })
    this.addSaveHotkey();
    this.dropUpload()
    this.pasteUpload()
  }

  saveContent() {
    const content = this.easyMDE.value()

    put(this.updateUrlValue, {
      responseKind: "turbo-stream",
      body: JSON.stringify({
        content: content
      })
    })
  }
  
  addSaveHotkey() {
    const extraKeys = this.easyMDE.codemirror.getOption('extraKeys') || {};

    // Extend the existing extraKeys with your custom hotkey
    extraKeys['Cmd-S'] = extraKeys['Ctrl-S'] = (cm) => {
      this.saveContent();
      return false; // Prevent the default "Save" action
    };

    this.easyMDE.codemirror.setOption('extraKeys', extraKeys);
  }

  
  triggerUploadDialog() {
    const fileInput = document.createElement('input')
    fileInput.type = 'file';
    fileInput.accept = this.allowDropFileTypes.join(',')
    fileInput.style.display = 'none'; // Hide the file input

    fileInput.addEventListener('change', (event) => {
      this.uploadFiles(event.target.files);
      fileInput.remove() // Clean up the file input from the DOM
    });

    document.body.appendChild(fileInput); // It needs to be in the DOM to be clickable
    fileInput.click() // Trigger the file dialog
  }

  dropUpload() {
    this.easyMDE.codemirror.on("drop", (instance, event) => {
      event.preventDefault()
      this.uploadFiles(event.dataTransfer.files)
    })
  }

  pasteUpload() {
    this.easyMDE.codemirror.on("paste", (instance, event) => {
      if (!event.clipboardData.files.length) return
      
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