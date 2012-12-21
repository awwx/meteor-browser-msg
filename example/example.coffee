if Meteor.isClient

  Meteor.BrowserMsg.listen
    shout: (say) ->
      alert say

  Template.hello.events
    'click #shout': ->
      Meteor.BrowserMsg.send 'shout', $('#say').val()
