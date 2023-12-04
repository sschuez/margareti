import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.classList.add("input-link")
    this.linkBtn = `
    <div data-action="click->add-url#addUrl" class="button input-link__btn">
      <i class="fas fa-link"></i>
    </div>
    `
    this.element.insertAdjacentHTML("afterbegin", this.linkBtn)
  }

  addUrl() {
    event.preventDefault()

    var start = this.inputTarget.selectionStart,
        end = this.inputTarget.selectionEnd,
        diff = end - start

    if (start >= 0 && start == end) {
      // Nothing selected, insert at cursor
      this.inputTarget.setRangeText(" [](https://www.)", start, end, "end")
      
      // Move cursor to the middle of []
      let newPos = start + 2; // 1 is the position right after the opening bracket [
      this.inputTarget.setSelectionRange(newPos, newPos);
      this.inputTarget.focus(); // Focus the input after setting the cursor position
    } else if (start >= 0) {
      // Text selected, replace with URL
      var selectedText = this.inputTarget.value.substring(start, end);
      this.inputTarget.setRangeText("[" + selectedText + "](https://www.)", start, end, "end")

      // Move cursor to after www.
      let newPos = start + selectedText.length + 15; // 15 is the length of ](https://www.
      this.inputTarget.setSelectionRange(newPos, newPos);
      this.inputTarget.focus(); // Focus the input after setting the cursor position
    }
  }
}
