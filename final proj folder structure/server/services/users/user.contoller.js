
import User from './user.model.js';

export async function getAllUsers(req, res) {
  //TODO: check permissions

  let users = await User.allUsers();

  if (!users)
    return res.status(404).json({ message: 'no users found' });

  return res.status(200).json({ message: 'found!', users });
}

export async function getUserById(req, res) {
  //TODO: check permissions
  //let id = req.params.id
  let { id } = req.params

  //validate ID format
  if (id.length < 11)
    return res.status(400).json({ message: "invalid id format" });

  let user = await User.findUser(id);

  if (!user)
    return res.status(404).json({ message: 'user not found' });

  return res.status(200).json({ message: 'found!', user });
}

export async function createNewUser(req, res) {
  let { id, name, age, email, password } = req.body;

  if (!id || !name || !age || !email || !password)
    return res.status(400).json({ message: "missing data" });

  if (password.length < 6)
    return res.status(400).json({ message: "weak password" });

  let user = new User(id, name, age, email, password);
  await user.addUser();
  return res.status(201).json({ message: "successfully added", user })

}

export async function updateUser(req, res) {
  let u = new User().update();
  res.send('updateUser');
}

export async function deleteUser(req, res) {
  res.send('deleteUser');
}