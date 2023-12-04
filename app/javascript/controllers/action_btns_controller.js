import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    this.updateCheckboxFromMeta();
  }

  toggleActionBtns(){
    const newState = this.stateFromMeta() === 'true' ? 'false' : 'true';
    this.setStateInMeta('show-action-btns', newState);
    this.updateCheckboxFromMeta();
    this.toggleActionButtons();
  }

  toggleActionButtons() {
    const actionBtnsControllers = this.application.controllers.filter(controller => {
      return controller.identifier === "action-authorisations"
    });

    actionBtnsControllers.forEach(controller => {
      if (this.stateFromMeta() === 'true') {
        controller.showAuthorizedActions();
      } else {
        controller.hideAuthorizedActions();
      }
    });
  }

  updateCheckboxFromMeta() {
    const showActionBtns = this.stateFromMeta() === 'true'
    // this.checkboxTarget.checked = showActionBtns
    this.application.controllers
      .filter(controller => controller.identifier === this.identifier)
      .forEach(controller => controller.checkboxTarget.checked = showActionBtns)
  }

  stateFromMeta() {
    return this.contentFromMeta('show-action-btns');
  }

  contentFromMeta(metaName) {
    const meta = document.querySelector(`meta[name="${metaName}"]`)
    return meta ? meta.content : null
  }

  setStateInMeta(metaName, value) {
    const meta = document.querySelector(`meta[name="${metaName}"]`)
    if (meta) {
      meta.content = value;
    }
  }
}
