import consumer from "./consumer.js";

consumer.subscriptions.create(
  { channel: "RoomChannel", room: "RoomChannel" },
  {
    connected() {
      console.log()
      console.log("connected");
    },

    disconnected() {
      console.log("disconnected");
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel

      if (window.location.pathname != "/rooms/show"){
        
        document.querySelector("#notifications").innerHTML = 
        `<a href="/rooms/show?target_user_id=${data.sender.id}"> ${data.sender.username} have sent you a message. </a>`;

      }
      
    },

    speak: function (message, recipientId) {
      console.log("speak,", message, recipientId);
      return this.perform("speak", {
        message: message,
        target_user: recipientId,
      });
    },
  }
);
