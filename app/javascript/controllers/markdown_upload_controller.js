import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"
import easyMDE from "easymde"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.easyMDE = new easyMDE({
      element: this.element,
      allowDropFileTypes: ["image/jpeg", "image/png", "image/gif"],
      toolbar: [
        "undo", "redo", "|", "bold", "italic", "strikethrough", "|", "heading-1", "heading-2", "heading-3", "|", "code", "quote", "|", "unordered-list", "ordered-list", "|", "link", "horizontal-rule", "|", "preview", "side-by-side", "fullscreen", "|", "guide"
      ]
    })
    this.dropUpload()
    this.pasteUpload()
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