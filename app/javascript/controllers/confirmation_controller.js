import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirmation"
export default class extends Controller {
  confirm(event) {
    if (!window.confirm("Are you sure?")) {
      event.preventDefault();
    }
  }
}
