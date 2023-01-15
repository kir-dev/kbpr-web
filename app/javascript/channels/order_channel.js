import consumer from "channels/consumer"

consumer.subscriptions.create("OrderChannel", {
  connected() {
  },

  disconnected() {
    // Called when the subscription has been terminated by the server


  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.getElementById('order_total_price').textContent= `${data['order_total_price']} JMF`
  }
});
