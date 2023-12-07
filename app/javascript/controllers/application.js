import { Application } from "@hotwired/stimulus"
import TextareaAutogrow from "stimulus-textarea-autogrow"

const application = Application.start()
application.register("textarea-autogrow", TextareaAutogrow)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

window.MetaTagManager = class {
  static getContent(metaName) {
    const meta = document.head.querySelector(`meta[name="${metaName}"]`);
    return meta ? meta.content : null;
  }
  
  static setContent(metaName, value) {
    let meta = document.head.querySelector(`meta[name="${metaName}"]`);
    if (!meta) {
      meta = document.createElement('meta');
      meta.name = metaName;
      document.head.appendChild(meta);
    }
    meta.content = value;
  }
}

export { application }