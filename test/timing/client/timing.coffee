Template.main.delay = ->
  Session.get('delay')

now = -> new Date().getTime()

BrowserMsg.listen
  'a_message': (time) ->
    Session.set('delay', (now() - time) + 'ms')

Template.main.events
  'click #send': ->
    BrowserMsg.send 'a_message', now()
