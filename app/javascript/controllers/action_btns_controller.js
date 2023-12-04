import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.state = "hidden"
  }

  toggleActionBtns(){
    this.state = this.state === "hidden" ? "visible" : "hidden"

    // All action btns, identified via data-controller="action-authorisations"
    const actionBtns = this.application.controllers.filter(controller => {
      return controller.identifier === "action-authorisations"
    })

    actionBtns.forEach(controller => {
      if (this.state === "hidden") {
        controller.hideAuthorizedActions()
      } else if (this.state === "visible") {
        controller.showAuthorizedActions()
      }
    })
  }
}
