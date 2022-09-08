import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import 'flatpickr/dist/flatpickr.min.css'

export default class extends Controller {
  static values = {
    disablerange: Array
  }

  connect() {
    let disableHash = []
    this.disablerangeValue.forEach(element => {
      disableHash.push({
        from: element[0],
        to: element[1]
      })
    })

    flatpickr(".datepicker", {
      minDate: "today",
      showMonths: 2,
      allowInput: true,
      disable: disableHash
    });
  }
}
