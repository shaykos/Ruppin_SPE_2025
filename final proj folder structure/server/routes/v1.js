import { Router } from "express";
import userRouter from "../services/users/user.router.js";
import uploadRouter from "../services/upload/upload.router.js";

const v1Router = new Router();

//add user microservice
v1Router.use('/users', userRouter);
v1Router.use('/uploads', uploadRouter);

export default v1Router;