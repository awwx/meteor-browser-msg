Package.describe({
  summary: "cross browser tab messaging"
})

Package.on_use(function (api) {
  api.use(
    [
      'coffeescript',
      'ejson',
      'useragent'
    ],
    'client'
  )
  api.export('BrowserMsg', 'client');
  api.add_files(['browser-msg.coffee'], 'client');
});
