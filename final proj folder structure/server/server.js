//import express
import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import {errorHandler} from './middlewares/errorHandler.js';
import v1Router from './routes/v1.js';

//set server port
const PORT = 5500;

//create server instance
const server = express();

//middleware
server.use(cors());
server.use(morgan("tiny"));

//add json and form support
server.use(express.json());
server.use(express.urlencoded({ extended: true }));

//create v1 router
server.use('/api/v1', v1Router);

//error handler
server.use(errorHandler);

//start server
server.listen(PORT, () => console.log(`http://localhost:${PORT}`));
