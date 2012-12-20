if Meteor.isClient

  Meteor.LocalMsg.listen
    shout: (say) ->
      alert say

  Template.hello.events
    'click #shout': ->
      Meteor.LocalMsg.send 'shout', $('#say').val()
