import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="markdown-clipboard"
export default class extends Controller {
  connect() {
    this.clipBoardButton = `
    <button data-action="clipboard#copy" class="button code-snippet__button">
      <i class="fas fa-paperclip"></i>
    </button>
    `
    this.codeSnippets = this.element.querySelectorAll("pre > code")
    this.codeSnippets.forEach((code) => {
      this.parent = code.closest("pre").parentNode
      
      this.parent.setAttribute("data-controller", "clipboard")
      this.parent.classList.add("code-snippet")
      this.parent.insertAdjacentHTML("afterbegin", this.clipBoardButton)
      code.setAttribute("data-clipboard-target", "source")
    })
  }
}
