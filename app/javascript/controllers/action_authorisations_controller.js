import { Controller } from "@hotwired/stimulus"
import MetaTagManager from "../helpers/meta_tag_manager"

export default class extends Controller {
  static targets = ["user", "admin", "accordion"]
  
  connect() {
    // this.accordionHasExpandableContent = this.hasValue('expandableContent')
    this.accordionHasExpandableContent = this.element.dataset.hasExpandableContent === "true"
    this.updateStateFromMeta();
  }
  
  updateStateFromMeta() {
    const showActionBtns = MetaTagManager.getContent('show-action-btns') === 'true';
    showActionBtns ? this.showAuthorizedActions() : this.hideAuthorizedActions();
  }
  
  showAuthorizedActions() {
    const isAdmin = MetaTagManager.getContent('current-person-admin') === 'true'
    const isCurrentUser = MetaTagManager.getContent('current-person-user') === 'true'

    this.updateVisibility(this.userTargets, isCurrentUser || isAdmin)
    this.updateVisibility(this.adminTargets, isAdmin)
    this.updateVisibility(this.accordionTargets, true || isCurrentUser || isAdmin)

    MetaTagManager.setContent('show-action-btns', 'true');
  }

  hideAuthorizedActions() {
    this.updateVisibility(this.userTargets, false)
    this.updateVisibility(this.adminTargets, false)
    this.updateVisibility(this.accordionTargets, this.accordionHasExpandableContent)

    MetaTagManager.setContent('show-action-btns', 'false');
  }

  updateVisibility(elements, shouldShow) {
    elements.forEach((element) => {
      element.classList.toggle("visually-hidden", !shouldShow)
    })
  }
}
