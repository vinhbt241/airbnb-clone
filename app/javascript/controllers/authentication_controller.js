import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = ["email"]

  submitForm(e) {
    e.preventDefault();

    let url = new URL('http://localhost:3000/authenticate_email')
    let params = { email: this.emailTarget.value }
    url.search = new URLSearchParams(params).toString();

    fetch(url, {
      headers: {
        'ACCEPT': 'application/json'
      }
    }).then((response) => {
      if(response.status == "404") {
        Turbo.visit('/users/sign_up')
      } else {
        Turbo.visit('/users/sign_in')
      } 
    }).catch((error) => {
      Turbo.visit('/users/sign_up')
    })
  }
}
