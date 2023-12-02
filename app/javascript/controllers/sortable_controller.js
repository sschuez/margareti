import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from "@rails/request.js"

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    group: String,
    draggable: String
  }

  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      draggable: this.hasDraggableValue ? this.draggableValue : null,
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
    const modelNames = ["blocks"]
    const regex = new RegExp(`^\/(${modelNames.join('|')})\/\\d+\/order$`)
    const index = regex.test(url) ? event.newIndex : event.newIndex + 1
    var sortableBlockId = event.to.dataset.sortableBlockId

    put(url, { 
      body: JSON.stringify({ 
        new_position: index,
        new_block_id: sortableBlockId
      })
    })
  }
}
