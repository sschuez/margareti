import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="action-authorisations"
export default class extends Controller {
  static targets = ["user", "admin", "accordion"]

  connect() {
    this.accordionHasExpandableContent = this.element.dataset.hasExpandableContent === "true"
    this.updateStateFromMeta();
  }

  updateStateFromMeta() {
    const showActionBtns = this.contentFromMeta('show-action-btns') === 'true';
    if (showActionBtns) {
      this.showAuthorizedActions();
    } else {
      this.hideAuthorizedActions();
    }
  }

  // This method can be called from another controller to show the buttons
  showAuthorizedActions() {
    const isAdmin = this.contentFromMeta('current-person-admin') === 'true'
    const isCurrentUser = this.contentFromMeta('current-person-user') === 'true'

    this.updateVisibility(this.userTargets, isCurrentUser || isAdmin)
    this.updateVisibility(this.adminTargets, isAdmin)
    this.updateVisibility(this.accordionTargets, true || isCurrentUser || isAdmin)

    this.setStateInMeta('show-action-btns', 'true');
  }

  // This method can be called from another controller to hide the buttons
  hideAuthorizedActions() {
    this.updateVisibility(this.userTargets, false)
    this.updateVisibility(this.adminTargets, false)
    this.updateVisibility(this.accordionTargets, this.accordionHasExpandableContent)

    this.setStateInMeta('show-action-btns', 'false');
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

  updateVisibility(elements, shouldShow) {
    elements.forEach((element) => {
      element.classList.toggle("visually-hidden", !shouldShow)
    })
  }
}
