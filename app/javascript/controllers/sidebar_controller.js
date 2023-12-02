import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = [ "toggle", "sub", "arrowIcon" ]

  connect() {
    this.arrowDown = `<i class="bi bi-caret-down-fill" id="caret"></i>`
    this.arrowLeft = `<i class="bi bi-caret-left-fill" id="caret"></i>`
  
    this.getArrowIcons()
  }

  getArrowIcons() {
    this.arrowIconTargets.forEach(arrow => {
      arrow.insertAdjacentHTML("beforebegin", this.arrowDown)
      arrow.remove()
    })
  }

  toggleOpen() {
    this.toggleTarget.classList.add("open");
  }

  toggleClose() {
    if (event.target.classList.contains("sidebar") || event.currentTarget.id === "close-button") {
      this.toggleTarget.classList.remove("open");
    }
  }

  // Generic close function for sidebar
  closeSidebar() {
    this.toggleTarget.classList.remove("open");
  }

  toggleSub() {
    const sub = event.currentTarget.querySelector("#sub")
    const arrow = event.currentTarget.querySelector("#caret")

    sub.classList.toggle("open")    
  
    if (sub.classList.contains("open")) {
      arrow.insertAdjacentHTML("beforebegin", this.arrowLeft)
      arrow.remove()
    } else {
      arrow.insertAdjacentHTML("beforebegin", this.arrowDown)
      arrow.remove()
    }
  }
}
