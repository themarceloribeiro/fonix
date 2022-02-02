import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log('Connected to ChatChannel')
  },

  disconnected() {
    console.log('Disconnected from ChatChannel')
  },

  received(data) {
    console.log('Received')
    console.log(data)
    var div = $('div')
    div.addClass('message-container')
    div.addClass('row')
    div.append(data.message)
    $('#messages_container').append(div)
  }
});

// .message-container.row
//   .body.col-md-10
//     %strong
//       = message.author.email
//     %p= message.body
//   .timestamp.col-md-2.right-aligned
//     = message.created_at.strftime('%b %a %d, %H:%M')
