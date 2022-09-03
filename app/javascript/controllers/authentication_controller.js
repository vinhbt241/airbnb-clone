import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['submit']
  
  connect() {
    this.submitTarget.addEventListener('click', e => {
      console.log("form submitted");
    })
  }
}
