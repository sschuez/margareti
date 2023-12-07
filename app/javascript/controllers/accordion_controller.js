import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "icon"]
  static values = { openAccordion: Boolean }

  connect() {
    this.state = this.openAccordionValue ? "open" : "closed"
    if (this.state === "open") this.dropdownTarget.classList.remove("visually-hidden")
    this.updateIcon();
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
