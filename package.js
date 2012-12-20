Package.describe({
  summary: "cross browser tab messaging"
})

Package.on_use(function (api) {
  api.add_files(['localmsg.js'], 'client');
});
