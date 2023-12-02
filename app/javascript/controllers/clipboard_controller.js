import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "input", "source" ]

  connect() {
    this.flashMessage = `
      <div
        class="flash__message"
        data-controller="removals"
        data-action="animationend->removals#remove">
        Copied to clipboard
      </div>
      `
    this.flashLocation = document.querySelector("#flash")
  }

  copy(event) {
    event.preventDefault()
    if (this.hasInputTarget) {
      const text = this.inputTarget.innerText + "\n" + this.sourceTarget.innerText
      navigator.clipboard.writeText(text)
    } else {
      navigator.clipboard.writeText(this.sourceTarget.innerText)
    }
    this.flashLocation.insertAdjacentHTML("afterbegin", this.flashMessage)
  }
}
