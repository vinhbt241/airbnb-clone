import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar", "modal"]
  
  connect() {
    document.addEventListener("click", e => {
      const isDropDownButton = e.target.matches("[data-dropdown-button]")

      if (!isDropDownButton && e.target.closest("[data-dropdown]") != null) return 

      let currentDropDown 
      if(isDropDownButton) {
        currentDropDown = e.target.closest("[data-dropdown]")
        currentDropDown.classList.toggle("active")
      }

      document.querySelectorAll("[data-dropdown].active").forEach(dropdown => {
        if(dropdown === currentDropDown) return 
        dropdown.classList.remove("active")
      })
    })

    this.modalTarget.addEventListener("click", () => {
      this.closeModal()
    })
  }

  scrollRight() {
    this.barTarget.scrollBy({
      top: 0,
      left: this.barTarget.offsetWidth / 2,
      behavior: 'smooth'
    })
  }

  scrollLeft() {
    this.barTarget.scrollBy({
      top: 0,
      left: -this.barTarget.offsetWidth / 2,
      behavior: 'smooth'
    })
  }

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
