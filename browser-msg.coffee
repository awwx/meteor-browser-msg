localStorage_message_key = 'Meteor.BrowserMsg.msg'

Meteor.BrowserMsg =

  _listeners: {}

  listen: (callbacks) ->
    @_listeners[name] = callback for name, callback of callbacks
    undefined

  send: (name, arg...) ->
    r = Math.random().toString().substr(2)
    v = JSON.stringify([name, arg...])
    localStorage.setItem localStorage_message_key, r + ':' + v
    undefined

window.addEventListener('storage',
  ((event) ->
    if event.key is localStorage_message_key
      val = event.newValue
      [name, arg...] = JSON.parse(val.substr(val.indexOf(':') + 1))
      Meteor.BrowserMsg._listeners[name]?(arg...)
      undefined
  ),
  false
)
