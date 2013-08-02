# browser-msg

Cross browser tab messaging.

browser-msg allows you to send a message to the other browser windows
and tabs open on your application in the same browser.

This works entirely within the browser, so it does not rely on the
Internet or use the connection to the Meteor server.


## Version

1.0.0


## API

To use, register which messages you'd like to listen to:

    BrowserMsg.listen({
      shout: function (saythis) {
        alert(saythis);
      },
      calc: function (a, b) {
        console.log(a * 2 + b);
      }
    });

Call `send` to broadcast a message to the other browser tabs:

    BrowserMsg.send('shout', 'Helllllo there!');

    BrowserMsg.send('calc', 300, 145);

The message will be received by all the other browser windows which
have registered to listen on the given method name.  (The message is
not delivered to the browser window which sends the message).

Messages are serialized using `EJSON.stringify`, and so can contain any
[EJSON-compatible value](http://docs.meteor.com/#ejson).

Messages are only delivered to windows running the same application,
as determined by the browser's
[same origin policy](https://en.wikipedia.org/wiki/Same_origin_policy).


## Implementation

browser-msg uses the local storage "storage" event to get a message to
the other browser tabs.  The key used is "Meteor.BrowserMsg.msg".


## Tests

In theory, a browser might have an optimization where it would only
deliver the last change event if the same storage key is changed more
than once.  That is, if two changes were made to the same key in the
same pass through the event loop,

    localStorage.setItem("foo", 123);
    localStorage.setItem("foo", 456);

perhaps a browser would send a "storage" event only for the second
one... which would defeat the browser-msg implementation.  The
consecutive-messages test in the test subdirectory checks that all
messages are in fact delivered.


## Unsupported Browsers

Chrome on iOS does not implement the local storage event.

IE 6 and IE 7 do not implement local storage.  (And the userData
feature, which can be used as a polyfill for storing data, does not
include a cross-tab storage change event).


## Support

Support my work by making a weekly contribution of your choice with
[Gittip](https://www.gittip.com/awwx/).
