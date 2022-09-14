import consumer from "./consumer"

consumer.subscriptions.create("ReservationChannel", {
  connected() {
    console.log("Reservation channel connnected")
  },

  disconnected() {
    console.log("Reservation channel disconnnected")
  },

  received(data) {
    console.log(data)
  }
});
