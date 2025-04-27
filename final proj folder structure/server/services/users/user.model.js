import bcrypt from 'bcryptjs';
import { findAllUsers, findSpecificUser, addUserToDB } from './user.db.js';

export default class User {
  constructor(id, name, age, email, password) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.email = email;
    this.password = bcrypt.hashSync(password, 15);
  }

  static async allUsers() {
    return await findAllUsers();
  }

  static async findUser(id) {
    return await findSpecificUser(id);
  }

  async addUser() {
    return await addUserToDB(this);
  }

}