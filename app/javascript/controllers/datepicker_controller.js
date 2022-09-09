import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';
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

    flatpickr(".datepicker-from", {
      minDate: "today",
      showMonths: 2,
      allowInput: true,
      disable: disableHash,
      plugins: [new rangePlugin({ input: ".datepicker-to"})]
    });
  }
}
