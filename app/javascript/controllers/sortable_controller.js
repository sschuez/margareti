import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from "@rails/request.js"

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String
  }

  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      filter: ".sortable-ignore-elements",
      animation: 150,
      group: this.groupValue,      
      handle: ".sortable-handle",  // Drag handle selector within list items
      ghostClass: "sortable-ghost",  // Class name for the drop placeholder
      chosenClass: "sortable-chosen",  // Class name for the chosen item
      dragClass: "sortable-drag",   // Class name for the dragging item
    })
  }

  onEnd(event) {
    const url = event.item.dataset.sortableUrl
    // The regex pattern to match /blocks/{number}/order
    const regex = /^\/blocks\/\d+\/order$/
    const isMatch = regex.test(url)
    const index = isMatch ? event.newIndex : event.newIndex + 1

    var sortableBlockId = event.to.dataset.sortableBlockId

    put(url, { 
      body: JSON.stringify({ 
        new_position: index,
        new_block_id: sortableBlockId
      })
    })
  }
}
