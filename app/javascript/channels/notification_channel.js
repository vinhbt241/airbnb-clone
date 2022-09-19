import consumer from "./consumer"
import { owner_property_reservations_path } from '../routes'

document.addEventListener("turbolinks:load", () => {
  const notification_icon = document.getElementById("notification-icon")
  const notification_messages_container = document.getElementById("notification-messages-container")
  
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
        console.log(data)
        switch(data.action) {
          case "increase":          
            const list_item = document.createElement("li")
            list_item.classList.add("text-md", "flex", "justify-between", "items-center")            

            const message_link = document.createElement("a")
            let message_url = owner_property_reservations_path({ property_id: data.property_id })
            message_link.href = message_url
            message_link.appendChild(document.createTextNode(data.message))
            list_item.appendChild(message_link)

            const unread_pin = document.createElement("div")
            unread_pin.classList.add("w-2", "h-2", "rounded-full", "bg-pinkRed")
            list_item.appendChild(unread_pin)

            if(notification_messages_container.innerHTML == "No notifications yet.") {
              notification_messages_container.innerHTML = ""
            } 
            
            notification_messages_container.prepend(list_item)

            notification_icon.style.display = "flex"
            notification_icon.innerText = Number(notification_icon.innerText) + 1
            break
          case "decrease":
            let current_notifications = Number(notification_icon.innerText) - 1
            if(current_notifications <= 0) {
              notification_icon.style.display = "none"
              notification_icon.innerText = "0"
            } else {
              notification_icon.innerText = current_notifications
            }
            break
          case "set_notifications":
            console.log(data.notifications)
            notification_icon.innerText = data.notifications 
            if(data.notifications > 0) {
              notification_icon.style.display = "flex"
            } 
            break
        }
      }
    });
  }
})





