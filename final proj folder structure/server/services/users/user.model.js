import bcrypt from 'bcryptjs';
import { ROLES } from './users.roles.js';
import { findAllUsers, findSpecificUser, addUserToDB, findUserByEmail } from './user.db.js';

export default class User {
  constructor(id, name, age, email, password, role = ROLES.USER) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.email = email;
    this.password = bcrypt.hashSync(password, 15);
    this.role = role;
  }

  static async allUsers() {
    return await findAllUsers();
  }

  static async findUser(id) {
    return await findSpecificUser(id);
  }

  static async login(email, password) {
    let user = await findUserByEmail(email);

    if (user && bcrypt.compareSync(password, user.password)) {
      delete user.password; // מוחק את השדה עבור המופע הנוכחי
      return user;
    }

    return null;
  }

  async addUser() {
    return await addUserToDB(this);
  }

}