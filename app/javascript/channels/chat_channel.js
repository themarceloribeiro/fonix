import consumer from "./consumer"

const render_message = function(data) {
  console.log('Received')
  console.log(data)

  var container = $('<div></div>')
  container.addClass('message-container')
  container.addClass('row')

  var body = $('<div></div>')
  body.addClass('body')
  body.addClass('col-md-10')

  const strong = $('<strong></strong>')
  strong.text(data.author)
  body.append(strong)

  const p = $('<p></p>')
  p.text(data.message)
  body.append(p)

  const timestamp = $('<div></div>')
  timestamp.addClass('timestamp')
  timestamp.addClass('col-md-2')
  timestamp.addClass('right-aligned')
  timestamp.text(data.timestamp)

  container.append(body)
  container.append(timestamp)

  container.insertBefore('.message-form-container')
}

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log('Connected to ChatChannel')
  },

  disconnected() {
    console.log('Disconnected from ChatChannel')
  },

  received(data) {
    render_message(data)
    $(document).scrollTop($(document).height())
  }
});
