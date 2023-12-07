import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "icon"]
  // static values = { hasExpandableContent: Boolean }

  connect() {
    this.state = "closed"
    // Required for external access to the value
    this.hasExpandableContent = this.element.dataset.hasExpandableContent === "true"
  }

  toggle(event) {
    this.dropdownTarget.classList.toggle("visually-hidden")
    this.state = this.state === "closed" ? "open" : "closed"
    this.updateIcon();
  }

  updateIcon() {
    const iconClassList = this.iconTarget.firstElementChild.classList
    iconClassList.replace(this.state === "open" ? "fa-plus" : "fa-minus", 
                          this.state === "open" ? "fa-minus" : "fa-plus")
  }
}
