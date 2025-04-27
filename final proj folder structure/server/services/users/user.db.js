import { readFile, writeFile } from 'fs/promises';
import path from 'path';
import { __dirname } from '../../globals.js';

export async function findAllUsers() {
  let users = await readFile(path.join(__dirname, 'DB', 'users.json'));
  return JSON.parse(users.toString());
}

export async function findSpecificUser(id) {
  let users = await readFile(path.join(__dirname, 'DB', 'users.json'));
  users = JSON.parse(users.toString());
  let user = users.find(u => u.id == id);
  return user;
}

export async function addUserToDB(user) {
  let users = await readFile(path.join(__dirname, 'DB', 'users.json'));
  users = JSON.parse(users.toString());

  users.push(user);

  await writeFile(path.join(__dirname, 'DB', 'users.json'), JSON.stringify(users));

  return user;
}

export async function findUserByEmail(email) {
  let users = await readFile(path.join(__dirname, 'DB', 'users.json'));
  users = JSON.parse(users.toString());
  let user = users.find(u => u.email == email);
  return user;
}