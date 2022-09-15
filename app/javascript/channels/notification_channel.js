import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
  const notification_icon = document.getElementById("notification-icon")
  
  if(notification_icon != null) {
    const user_id = notification_icon.getAttribute('data-user-id')

    consumer.subscriptions.create({ channel: "NotificationChannel", user_id: user_id }, {
      connected() {
        console.log('Channel connected to ' + user_id)
      },
    
      disconnected() {
        console.log('Channel disconnected')
      },
    
      received(data) {
        if(data.action == "increase") {
          notification_icon.style.display = "flex"
          notification_icon.innerText = Number(notification_icon.innerText) + 1
        } else if (data.action == "decrease") {
          let current_notifications = Number(notification_icon.innerText) - 1

          if(current_notifications <= 0) {
            notification_icon.style.display = "hidden"
            notification_icon.innerText = "0"
          } else {
            notification_icon.innerText = current_notifications
          }
        }
      }
    });
  }
})





