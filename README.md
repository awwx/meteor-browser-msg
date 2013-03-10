browser-msg
===========

Cross browser tab messaging.

browser-msg allows you to send a message to all the *other* browser tabs
and windows open on your application in the same browser.

This works entirely within the browser, so it does not rely on the
Internet or use the connection to the Meteor server.

To use, register which messages you'd like to listen to:

    Meteor.BrowserMsg.listen({
      shout: function (saythis) {
        alert(saythis);
      },
      calc: function (a, b) {
        console.log(a * 2 + b);
      }
    });

Call `send` to broadcast a message to the other browser tabs:

    Meteor.BrowserMsg.send('shout', 'Helllllo there!');

    Meteor.BrowserMsg.send('calc', 300, 145);

The message will be received by all the other browser tabs which have
registered to listen on the given method name.  (The message is not
delivered to the browser window which sends the message).

I chose not to implement some kind of automatic callback or return
value from sending a message because A) the user can have multiple
tabs open, and so if a reply was implemented there would be multiple
replies, and B) the user can open and close tabs at any time, so we
wouldn't know when all the replies had been received.  But of course
you simply broadcast and listen to your own replies if desired.


Implementation
--------------

browser-msg uses the local storage "storage" event to get a message to
the other browser tabs.  The key used is "Meteor.BrowserMsg.msg".

A browser might have an optimization where it would only deliver the
last change event if the same storage key is changed more than once.
That is, if two changes were made to the same key in the same pass
through the event loop,

    localStorage.setItem("foo", 123);
    localStorage.setItem("foo", 456);

perhaps some clever browser would send a "storage" event only for the
second one... which would defeat the browser-msg implementation.  The
test in the test subdirectory checks that a browser does in fact not
do that.


Unsupported Browsers
--------------------

Chrome on iOS does not implement the local storage event.

IE 6 and IE 7 do not implement local storage.  (IE's userData feature
stores data but does not include a cross-tab storage change event).
