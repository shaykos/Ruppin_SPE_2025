import 'dotenv/config';
import express from 'express';
import { writeLogEntry } from './middleware/log.js';
import DB from './utils/DB.js';

const PORT = process.env.PORT || 4321;

const server = express();
server.use(express.json({ limit: '50mb' }));
server.use(express.urlencoded({ extended: true }));

server.get('/', writeLogEntry, async (req, res) => {
  let db = new DB().createInstance();

  db.updateDocument();
})

server.listen(PORT, () => { console.log(`server is running... http://localhost:${PORT}`) });