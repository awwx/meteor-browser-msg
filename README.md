# browser-msg

Cross browser tab messaging.

browser-msg allows you to send a message to the other browser windows
and tabs open on your application in the same browser.

This works entirely within the browser, so it does not rely on the
Internet or use the connection to the Meteor server.

Messages are protected by the browser's
[same origin policy](https://en.wikipedia.org/wiki/Same_origin_policy).
That is, messages will not be delivered to windows open on a different
hostname or port number; and windows open on a different hostname or
port number will not be able to listen in on messages sent from your
application.


## Version

1.1.0

This version works with Meteor 0.6.5 and above only.  (Use browser-msg
version 1.0.1 for older Meteor versions).


## API

### BrowserMsg.supported

`BrowserMsg.supported`  *client*

A constant, `true` or `false`.  True if this browser supports
cross-window messaging.  When false, you can still call
`BrowserMsg.listen` and `BrowserMsg.send`, but it won't have any
effect.


### BrowserMsg.listen

`BrowserMsg.listen(methods)`  *client*

Register which messages you'd like to listen to:

    BrowserMsg.listen({
      shout: function (saythis) {
        alert(saythis);
      },
      calc: function (a, b) {
        console.log(a * 2 + b);
      }
    });


### BrowserMsg.send

`BrowserMsg.send(topic [, arg, arg...])` *client*

Call `send` to broadcast a message to the other browser tabs:

    BrowserMsg.send('shout', 'Helllllo there!');

    BrowserMsg.send('calc', 300, 145);

The message will be received by all the other browser windows which
have registered to listen on the given method name.  (The message is
not delivered to the browser window which sends the message).

Messages are serialized using `EJSON.stringify`, and so can contain any
[EJSON-compatible value](http://docs.meteor.com/#ejson).


## Unsupported Browsers

These browsers don't support cross-window messaging (and
`BrowserMsg.supported` will be `false`).

* IE 8 and older.

* Chrome for iOS devices such as the iPhone and the iPad.  (The
  desktop Chrome browser works fine!)


## Implementation

browser-msg uses the local storage "storage" event to send a message
to the other browser tabs.  The key used is "Meteor.BrowserMsg.msg".


## Tests

In theory, a browser might have an optimization where it would only
deliver the last change event if the same storage key is changed more
than once.  That is, if two changes were made to the same key in the
same pass through the event loop,

    localStorage.setItem("foo", 123);
    localStorage.setItem("foo", 456);

perhaps a browser would send a "storage" event only for the second
one... which would defeat the browser-msg implementation.

The consecutive-messages test in the test subdirectory checks that all
messages are in fact delivered.


## Donate

An easy and effective way to support the continued maintenance of this
package and the development of new and useful packages is to [donate
through Gittip](https://www.gittip.com/awwx/).

Gittip is a [platform for sustainable
crowd-funding](https://www.gittip.com/about/faq.html).

Help build an ecosystem of well maintained, quality Meteor packages by
joining the
[Gittip Meteor Community](https://www.gittip.com/for/meteor/).


## Hire

Need support, debugging, or development for your project?  You can
[hire me](http://awwx.ws/hire-me) to help out.
