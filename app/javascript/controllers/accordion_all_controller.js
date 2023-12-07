// app/javascript/controllers/accordion_all_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  connect() {
    this.state = "closed"
  }

  toggleBlock() {
    this.toggle(this.registerControllers())
  }

  registerControllers() {
    const accordionControllers = this.application.controllers.filter(controller => {
      return controller.identifier === "accordion" &&  
                                        this.element.contains(controller.element) && 
                                          controller.iconTargets.length > 0 &&
                                            controller.hasExpandableContent
    })
    return accordionControllers
  }

  toggle(scope) {
    const anyClosed = scope.some(controller => controller.state === "closed")

    scope.forEach(controller => {
      if (anyClosed && controller.state === "closed") {
        controller.toggle()
      } else if (!anyClosed && controller.state === "open") {
        controller.toggle()
      }
    });

    this.state = anyClosed ? "open" : "closed"
    this.updateIcon();
  }

  updateIcon() {
    const iconClassList = this.iconTarget.firstElementChild.classList
    iconClassList.replace(this.state === "open" ? "fa-plus" : "fa-minus", 
                          this.state === "open" ? "fa-minus" : "fa-plus")
  }
}
