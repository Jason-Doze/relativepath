import express from 'express';
import cors from 'cors';
import path from 'path';

const app = express();
const port = 3000;

// Enable CORS requests
app.use(cors());

// Set up a middleware to serve static files from the public folder
app.use('/', express.static(path.resolve('public'))); 

// Serve the favicon
app.get('/favicon.ico', (req, res) => {
  const faviconPath = path.resolve('public/images/favicon.ico');
  res.sendFile(faviconPath);
});

// Start the server and listen on all available network interfaces on port 3000
app.listen(port, () => {
  console.log('App listening on port ${port}');
});

