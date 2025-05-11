import bcrypt from "bcryptjs";
import { ROLES } from '../../global.js';
import DB from '../db.js';

export default class User {
    constructor({ name, email, password, role = ROLES.USER }) {
        this.role = role; // Default role is 'user'
        this.name = name;
        this.email = email;
        this.password = bcrypt.hashSync(password, 15); // Hash the password before saving
    }

    static async getAllUsers() {
        try {
            let q = `select * from Users`;
            return await DB.selectData(q);
        } catch (error) {
            throw new Error('An error occurred while fetching users.');
        }
    }

    
}