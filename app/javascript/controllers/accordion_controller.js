import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = [ "dropdown", "icon" ]

  connect() {
    this.state = "closed"
    this.hasExpandableContent = this.element.dataset.hasExpandableContent === "true"
    
    // if (!this.hasExpandableContent) {
      // this.iconTarget.classList.add("visually-hidden")
    // }
  }

  get state() {
    return this._state;
  }

  set state(value) {
    this._state = value;
  }

  toggle(event) {
    this.dropdownTarget.classList.toggle("visually-hidden")
    this.state = this.state === "closed" ? "open" : "closed"
    const iconClassList = this.iconTarget.firstElementChild.classList
    
    if (this.state === "open") {
      iconClassList.replace("fa-plus", "fa-minus")
    } else {
      iconClassList.replace("fa-minus", "fa-plus")
    }
  }
}
