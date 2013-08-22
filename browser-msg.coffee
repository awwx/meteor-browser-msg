BrowserMsg = {}


browser = Useragent.browser
if ((browser.family is 'ie' and browser.major < 9) or
    (browser.family is 'chromeMobileIOS'))
  BrowserMsg.supported = false
  BrowserMsg.listen = ->
  BrowserMsg.send = ->
  return


BrowserMsg.supported = true


localStorage_message_key = 'Meteor.BrowserMsg.msg'


listeners = {}


BrowserMsg.listen = (callbacks) ->
  listeners[name] = callback for name, callback of callbacks
  return


BrowserMsg.send = (name, arg...) ->
  r = Math.random().toString().substr(2)
  v = EJSON.stringify([name, arg...])
  localStorage.setItem localStorage_message_key, r + ':' + v
  return


onstorage = (event) ->
  if event.key is localStorage_message_key
    val = event.newValue
    [name, arg...] = EJSON.parse(val.substr(val.indexOf(':') + 1))
    listeners[name]?(arg...)
  return


if window.addEventListener?
  window.addEventListener('storage', onstorage, false)
