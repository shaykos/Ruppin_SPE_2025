import { Router } from 'express';
import { isAdmin } from '../../middlewares/auth.js';
import { getAllUsers, addUser, login } from './users.controller.js';

const usersRouter = Router();


usersRouter
    .get('/', isAdmin, getAllUsers)
    // .get('/:id', getBookById)
    .post('/', addUser)
    .post('/login', login)
// .put('/:id', updateBook)
// .delete('/:id', deleteBook);

// Export the router
export default usersRouter;