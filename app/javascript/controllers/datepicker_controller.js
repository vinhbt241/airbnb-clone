import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import 'flatpickr/dist/flatpickr.min.css'

export default class extends Controller {
  connect() {
    flatpickr(".datepicker", {
      minDate: "today",
      showMonths: 2
    });
  }
}
