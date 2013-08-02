if Package?
  browserMsg = BrowserMsg = {}
else
  browserMsg = @BrowserMsg = {}


localStorage_message_key = 'Meteor.BrowserMsg.msg'


listeners = {}


browserMsg.listen = (callbacks) ->
  listeners[name] = callback for name, callback of callbacks
  return


browserMsg.send = (name, arg...) ->
  r = Math.random().toString().substr(2)
  v = EJSON.stringify([name, arg...])
  localStorage.setItem localStorage_message_key, r + ':' + v
  return


if window.addEventListener?
  window.addEventListener('storage',
    ((event) ->
      if event.key is localStorage_message_key
        val = event.newValue
        [name, arg...] = EJSON.parse(val.substr(val.indexOf(':') + 1))
        listeners[name]?(arg...)
      return
    ),
    false
  )
