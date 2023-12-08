import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage";
import { Dropzone } from "dropzone";
import { destroy } from "@rails/request.js"

export default class extends Controller {
  static targets = ["input", "existingFile", "dropzoneMsg"]

  connect() {
    this.dropZone = this.createDropZone(this)
    this.hideFileInput()
    this.bindEvents()
    Dropzone.autoDiscover = false
    this.displayExistingFiles()
    this.displayDropzoneMsg()
  }

  displayDropzoneMsg() {
    if (this.element.querySelector(".dz-preview")) {
      this.dropzoneMsgTarget.style.display = "none"
    } else {
      this.dropzoneMsgTarget.style.display = "block"
    }
  }

  // Private
  displayExistingFiles() {
    this.existingFileTargets.forEach((file) => {
      const mockFile = { 
        name: file.dataset.filename, 
        size: Number(file.dataset.size), 
        blob_id: file.dataset.blobId, 
        accepted: true,
        mock: true 
      }

      this.dropZone.emit("addedfile", mockFile)
      this.dropZone.emit("thumbnail", mockFile, file.dataset.url)
      this.dropZone.emit("complete", mockFile)
      
      this.resizeThumbnail(mockFile)
    })    
  }
  
  resizeThumbnail(mockFile) {
    const thumbnailElement = mockFile.previewElement.querySelector(".dz-image img")
    thumbnailElement.width = 120
    thumbnailElement.height = 120
    thumbnailElement.style.objectFit = "cover"
  }

  hideFileInput() {
    this.inputTarget.disabled = true
    this.inputTarget.style.display = "none"
  }

  bindEvents() {
    this.dropZone.on("addedfile", file => {
      if (!file.mock) {
        setTimeout(() => {
          file.accepted && this.createDirectUploadController(this, file).start()
        }, 500)
      }

      this.displayDropzoneMsg() 
    })

    this.dropZone.on("removedfile", file => {
      file.controller && this.removeElement(file.controller.hiddenInput)
      
      this.deleteBlobAndAttachment(file.blob_id)
      this.displayDropzoneMsg() 
    })
    
    this.dropZone.on("canceled", file => {
      file.controller && file.controller.xhr.abort()

      this.displayDropzoneMsg() 
    })
  }

  async deleteBlobAndAttachment(blob_id) {
    const response = await destroy(`/file_uploads/${blob_id}`, {
      responseKind: "turbo-stream",
    })
    if (response.ok) {
      console.log("Yai, deleted!")
      this.dropZone.options.maxFiles += 1
    }
  }

  get headers() {
    return { "X-CSRF-Token": this.getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url")
  }

  get maxFiles() {
    return (this.data.get("maxFiles") - this.existingFileTargets.length) || 1;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get dictFileTooBig() {
    return this.data.get("dictFileTooBig") || "File size is {{filesize}} but only files up to {{maxFilesize}} are allowed";
  }

  get dictInvalidFileType() {
    return this.data.get("dictInvalidFileType") || "Invalid file type";
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles")
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }

  getMetaValue(name) {
    const element = this.findElement(document.head, `meta[name="${name}"]`)
    if (element) {
      return element.getAttribute("content")
    }
  }

  findElement(root, selector) {
    if (typeof root == "string") {
      selector = root;
      root = document;
    }
    return root.querySelector(selector)
  }

  removeElement(el) {
    if (el && el.parentNode) {
      el.parentNode.removeChild(el)
    }
  }

  createDirectUploadController(source, file) {
    return new DirectUploadController(source, file)
  }

  createDropZone(controller) {
    return new Dropzone(controller.element, {
      url: controller.url,
      headers: controller.headers,
      maxFiles: controller.maxFiles,
      maxFilesize: controller.maxFileSize,
      dictFileTooBig: controller.dictFileTooBig,
      dictInvalidFileType: controller.dictInvalidFileType,
      acceptedFiles: controller.acceptedFiles,
      addRemoveLinks: controller.addRemoveLinks,
      autoQueue: false
    })
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = this.createDirectUpload(file, source.url, this)
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput()
    this.directUpload.create((error, attributes) => {
      if (error) {
        this.removeElement(this.hiddenInput)
        this.emitDropzoneError(error)
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess()
      }
    })
  }

  createHiddenInput() {
    const input = document.createElement("input")
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    this.insertAfter(input, this.source.inputTarget)
    return input;
  }

  insertAfter(el, referenceNode) {
    return referenceNode.parentNode.insertBefore(el, referenceNode.nextSibling)
  }

  removeElement(el) {
    if (el && el.parentNode) {
      el.parentNode.removeChild(el)
    }
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr)
    this.emitDropzoneUploading()
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", event =>
      this.uploadRequestDidProgress(event)
    )
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    this.findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  findElement(root, selector) {
    if (typeof root == "string") {
      selector = root;
      root = document;
    }
    return root.querySelector(selector)
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file)
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error)
    this.source.dropZone.emit("complete", this.file)
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file)
    this.source.dropZone.emit("complete", this.file)
  }

  createDirectUpload(file, url, controller) {
    return new DirectUpload(file, url, controller)
  }
}