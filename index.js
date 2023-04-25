import express from 'express';
import cors from 'cors';


const app = express();

// Enable CORS requests
app.use(cors());

// Set up a middleware to serve static files from the public folder
app.use(express.static('public'));

// Serve the favicon
app.get('/favicon.ico', (req, res) => {
  const faviconPath = './public/images/favicon.ico';

  // Read the contents of the favicon file using fs.readFile
  fs.readFile(faviconPath, (err, data) => {
    if (err) {
      console.error(err);
      res.sendStatus(404);
    } else {
      // Set the content type to image/x-icon
      res.set('Content-Type', 'image/x-icon');

      // Send the favicon file as a response
      res.send(data);
    }
  });
});

// Serve the index.html file
app.get('/', (req, res) => {
  const indexPath = path.join(__dirname, 'public', 'index.html');
  res.sendFile(indexPath);
});

// Serve the favicon
app.get('/favicon.ico', (req, res) => {
  const faviconPath = './public/images/favicon.ico';
  res.sendFile(faviconPath);
});

// Start the server and listen on all available network interfaces on port 3000
app.listen(3000, () => {
  console.log('App listening on port 3000');
});

