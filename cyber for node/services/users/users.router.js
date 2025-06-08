import { Router } from "express";
import { writeLogEntry } from "../../middleware/log.js";
import {getAllUsers} from './users.controller.js'


const userRouter = Router();

userRouter
  .get('/', writeLogEntry, getAllUsers)

export default userRouter