import { SECRET } from "../globals.js";
import { ROLES } from "../services/users/users.roles.js";
import jwt from 'jsonwebtoken';

export async function auth(req, res, next) {
  let token = req.headers.authorization.split(' ')[1];
  let user = jwt.verify(token, SECRET);
  console.log(user);
  if (user.role != ROLES.ADMIN)
    return res.status(403).json({ message: "auth failed!" });

  next();
}