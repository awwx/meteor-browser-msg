Template.main.delay = ->
  Session.get('delay')

Meteor.BrowserMsg.listen
  'a_message': (time) ->
    Session.set('delay', (new Date().getTime() - time) + 'ms')

Template.main.events
  'click #send': ->
    Meteor.BrowserMsg.send 'a_message', new Date().getTime()
