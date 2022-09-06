import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";
import { authenticate_email_path } from '../routes'

export default class extends Controller {
  static targets = ["email"]

  submitForm(e) {
    e.preventDefault();

    let url = authenticate_email_path({ email: this.emailTarget.value })

    fetch(url, {
      headers: {
        'ACCEPT': 'application/json'
      }
    }).then((response) => {
      if(response.status == "204") {
        Turbo.visit('/users/sign_up')
      } else {
        Turbo.visit('/users/sign_in')
      } 
    }).catch((error) => {
      Turbo.visit('/users/sign_up')
    })
  }
}
