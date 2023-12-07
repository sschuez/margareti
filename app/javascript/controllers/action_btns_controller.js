import { Controller } from "@hotwired/stimulus"
import MetaTagManager from "../helpers/meta_tag_manager"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    this.updateCheckboxFromMeta();
  }

  toggleActionBtns() {
    const newState = MetaTagManager.getContent('show-action-btns') !== 'true';
    MetaTagManager.setContent('show-action-btns', newState.toString());
    this.updateCheckboxFromMeta();
    this.toggleActionButtons(newState);
  }

  toggleActionButtons(newState) {
    const actionBtnsControllers = this.application.controllers.filter(controller => {
      return controller.identifier === "action-authorisations"
    });

    actionBtnsControllers.forEach(controller => {
      newState ? controller.showAuthorizedActions() : controller.hideAuthorizedActions();
    });
  }

  updateCheckboxFromMeta() {
    const showActionBtns = MetaTagManager.getContent('show-action-btns') === 'true'
    this.checkboxTarget.checked = showActionBtns
  }
}
