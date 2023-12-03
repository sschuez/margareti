import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="links"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.classList.add("input-link")
    this.linkBtn = `
    <button data-action="click->link#addUrl" class="button input-link__btn">
      <i class="fas fa-link"></i>
    </button>
    `
    this.element.insertAdjacentHTML("afterbegin", this.linkBtn)
    this.preventEnter()
  }

  preventEnter() {
    this.inputTarget.addEventListener("keydown", function(e) {
      if (e.keyCode === 13 || e.key === "Enter") {
        e.preventDefault()
      }
    })
  }

  addUrl() {
    event.preventDefault()

    var start = this.inputTarget.selectionStart,
        end = this.inputTarget.selectionEnd,
        diff = end - start

    if (start >= 0 && start == end) {
      // do cursor position actions, example:
      console.log('Cursor Position: ' + start);
      this.inputTarget.setRangeText(" [](https://)", start, end, "end")
    } else if (start >= 0) {
      // do ranged select actions, example:
      console.log('Cursor Position: ' + start + ' to ' + end + ' (' + diff + ' selected chars)');
      // Get the selected text
      var selectedText = this.inputTarget.value.substring(start, end);
      // Replace the selected text with the URL format
      this.inputTarget.setRangeText("[" + selectedText + "](https://)", start, end, "end")
    }
  }
}
