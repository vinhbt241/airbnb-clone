// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "../controllers"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.

import '../stytesheets'
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import { Application } from "@hotwired/stimulus"

const application = Application.start()
export { application }
import * as Routes from '../routes';
window.Routes = Routes;

import flatpickr from "flatpickr"
import 'flatpickr/dist/flatpickr.min.css'

import '@stripe/stripe-js';
