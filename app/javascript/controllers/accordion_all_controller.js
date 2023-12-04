import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion-all"
export default class extends Controller {
  static targets = [ "icon" ]

  connect() {
    this.state = "closed"

    if (this.element.dataset.hasExpandableContent === "false") {
      this.iconTarget.classList.add("visually-hidden")
    }
  }
  
  toggleBlock() {
    const accordionControllers = this.application.controllers.filter(controller => {
      return controller.identifier === "accordion" &&  
                                        this.element.contains(controller.element) && 
                                          controller.iconTargets.length > 0 &&
                                            controller.hasExpandableContent
    })

    this.toggle(accordionControllers)
  }
  
  toggle(scope) {
    this.setState()
    
    // Check if any accordion is closed
    const anyClosed = scope.some(controller => controller.state === "closed")

    // If any accordion is closed, open all. Otherwise, close all.
    scope.forEach(controller => {
      if (anyClosed && controller.state === "closed") {
        controller.toggle()
      } else if (!anyClosed && controller.state === "open") {
        controller.toggle()
      }
    });

    // Update the state of the overarching controller
    this.state = anyClosed ? "open" : "closed"
  }

  setState() {
    const iconClassList = this.iconTarget.firstElementChild.classList
    
    this.state = this.state === "closed" ? "open" : "closed"

    if (this.state === "open") {
      iconClassList.replace("fa-plus", "fa-minus")
    } else {
      iconClassList.replace("fa-minus", "fa-plus")
    }
  }
}
