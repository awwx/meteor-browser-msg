localmsg
========

Cross browser tab messaging.

localmsg allows you to send a message to all the *other* browser tabs
and windows open on your application in the same browser.

This works entirely within the browser, so it does not rely on the
Internet or use the connection to the Meteor server.

To use, register which messages you'd like to listen to:

    Meteor.LocalMsg.listen({
      shout: function (saythis) {
        alert(saythis);
      },
      calc: function (a, b) {
        console.log(a * 2 + b);
      }
    });

Call `send` to broadcast a message to the other browser tabs:

    Meteor.LocalMsg.send('shout', 'Helllllo there!');

    Meteor.LocalMsg.send('calc', 300, 145);

The message will be received by all the other browser tabs which have
registered to listen on the given method name.  (The message is not
delivered to the browser window which sends the message).

I chose not to implement some kind of automatic callback or return
value from sending a message because A) the user can have multiple
tabs open, and so if a reply was implemented there would be multiple
replies, and B) the user can open and close tabs at any time, so we
wouldn't know when all the replies had been received.  But of course
you simply broadcast and listen to your own replies if desired.
