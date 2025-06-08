import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import userRouter from './services/users/users.router.js';
import { errorHandler } from './middleware/errorHandler.js';
import { apiLimiter } from './middleware/ratelimit.js';

const PORT = process.env.PORT || 4321;

const server = express();
server.use(express.json({ limit: '50mb' }));
server.use(express.urlencoded({ extended: true }));
server.use(cors({
  origin: ['http://example.com', 'http://localhost:5500', 'http://127.0.0.1:5500'],
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204,
  methods: "GET,HEAD,PUT,PATCH,POST,DELETE"
}));

server.use('/users', apiLimiter, userRouter);

//error handler
server.use(errorHandler);

server.listen(PORT, () => { console.log(`server is running... http://localhost:${PORT}`) });