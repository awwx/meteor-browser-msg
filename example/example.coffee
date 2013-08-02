if Meteor.isClient

  BrowserMsg.listen
    shout: (say) ->
      alert say

  Template.hello.events
    'click #shout': ->
      BrowserMsg.send 'shout', $('#say').val()
