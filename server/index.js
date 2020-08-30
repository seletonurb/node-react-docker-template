const express = require('express');
const path = require('path');
const app = express();

const distFolder = path.join(__dirname, '../client/build');
app.use(express.static(distFolder));

// always return the main index.html, so react-router renders the router in the client
app.get('*', (req, res) => res.sendFile(path.join(distFolder, 'index.html')));

/* error handlers */
app.set('port', 8080);

const server = app.listen(app.get('port'), function () {
  console.log(`Express server listening on port ${server.address().port}`);
});

module.exports = app;
