import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  
  showModal() {
    this.modalTarget.classList.remove("hidden")

    document.querySelectorAll("[data-dropdown].active").forEach(dropdown => {
      dropdown.classList.remove("active")
    })
    document.body.classList.add("modal-active")
  }

  closeModal() {
    this.modalTarget.classList.add("hidden")
    document.body.classList.remove("modal-active")
  }
}
