import 'dotenv/config'; //הגדרת השרת לקבלת משתני סביבה מהקובץ .env
import express from 'express';
import booksRouter from './services/books/books.routes.js';
import usersRouter from './services/users/users.routes.js';
const PORT = process.env.PORT || 5500;

//הגדרת השרת
const server = express();
server.use(express.json({limit: '50mb'}));
server.use(express.urlencoded({ extended: true })); //תמיכה בכתובת בתווים שאינם לטיניים

//route --> controller --> model --> database
server.use('/api/books', booksRouter);
server.use('/api/users', usersRouter);

server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});