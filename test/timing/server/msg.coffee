# only works for one client at a time

sentAt = null

Meteor.methods
  sendingMessageAt: (time) ->
    sentAt = time

  receivedMessageAt: (time) ->
    console.log 'message delay', (time - sentAt) + "ms"
