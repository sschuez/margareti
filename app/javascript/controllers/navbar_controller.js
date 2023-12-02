import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "menu", "navList", "close" ]

  connect() {
    this.overlay = document.querySelector("div.overlay")
  }

  open() {
    this.navListTarget.classList.toggle('show')
    this.overlay.classList.toggle('show')
    this.menuTarget.classList.toggle('visually-hidden')
    this.closeTarget.classList.toggle('show')
  }

  close() {
    this.open(e)
  }
}
