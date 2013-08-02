Package.describe({
  summary: "cross browser tab messaging"
})

Package.on_use(function (api) {
  api.use('coffeescript');
  api.use('ejson');
  if (api.export)
    api.export('BrowserMsg', 'client');
  api.add_files(['browser-msg.coffee'], 'client');
});
