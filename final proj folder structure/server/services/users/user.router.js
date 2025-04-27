import { Router } from 'express';
import { getAllUsers, getUserById, createNewUser, updateUser, deleteUser, loginUser } from './user.contoller.js';
//import * as ctrl from './user.contoller.js';

function logger (req, res, next) {
  console.log(`${req.method} ${req.url}`);
  next();
 };
 

const userRouter = Router();

userRouter
  //.get('/', ctrl.getAllUsers)
  .get('/', logger, getAllUsers)
  .get('/profile/:id', getUserById)
  .post('/', createNewUser)
  .post('/login', loginUser)
  .put('/:id', updateUser)
  .delete('/:id', deleteUser)

export default userRouter;
