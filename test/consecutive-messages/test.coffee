if Meteor.isClient

  switch window.location.pathname
    when '/'
      window.name = 'parent'
      Session.set('show', 'home')
    when '/child1'
      window.name = 'child1'
      Session.set('show', 'child1')

  _when = window.when

  Template.route.show_home   = -> Session.equals('show', 'home')
  Template.route.show_child1 = -> Session.equals('show', 'child1')

  Session.set('test_status', 'wait')
  Template.test_browsermsg_home.test_status = -> Session.get('test_status')

  parent_start = false
  parent_startup = ->
    throw new Error 'oops parent_startup called twice' if parent_start
    parent_start = true

    localStorage.clear()

    next_expected = 1

    running = true
    timeout_set = false

    BrowserMsg.listen
      step: (i) ->

        return unless running

        unless timeout_set
          setTimeout(
            (->
              return unless running
              running = false
              Session.set('test_status', 'failed')
              console.log 'timeout'
            ),
            3000
          )
          timeout_set = true

        if i is next_expected
          if i is 20
            running = false
            localStorage.setItem('test_browsermsg.child1.close', 'true')
            Session.set('test_status', 'successful')
          else
            ++next_expected
        else
          running = false
          Session.set('test_status', 'failed')

    Session.set('test_status', 'ready')


  child1_start = false
  child1_startup = ->
    throw new Error 'oops child1_startup called twice' if child1_start
    child1_start = true

    storage_change = (key, val) ->
      if key is 'test_browsermsg.child1.close' and val is 'true'
        # IE will popup a dialog asking whether to close the window.
        # When running in Saucelabs, we use their popup handler to take
        # care of it by setting disable-popup-handler to false.
        window.close()

    window.addEventListener(
      'storage',
      ((event) -> storage_change(event.key, event.newValue)),
      false
    )

    for i in [1..20]
      BrowserMsg.send 'step', i

  Template.test_browsermsg_home.created = ->
    parent_startup()

  Template.test_browsermsg_child1.created = ->
    child1_startup()
