import CableReady from "cable_ready"
import consumer from "./consumer"

consumer.subscriptions.create("FeedChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("consumer connected to feed channel...")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("consumer disconnected from feed channel...")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel

    // if data is cable ready, perform job for data 
    if (data.cableReady) {
      CableReady.perform(data.operation)
    }
  }
});
