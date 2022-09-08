import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bar"]

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
}
