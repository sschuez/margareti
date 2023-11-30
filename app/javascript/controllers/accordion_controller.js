import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = [ "dropdown" ]

  connect() {
    this.state = "closed"
  }

  toggle(event) {
    this.dropdownTarget.classList.toggle("visually-hidden")
    this.icon = event.target
    this.state = this.state === "closed" ? "open" : "closed"
    
    console.log(this.state)
    
    if (this.state === "open") {
      this.icon.classList.replace("fa-plus", "fa-minus")
    } else {
      this.icon.classList.replace("fa-minus", "fa-plus")
    }
  }
}
