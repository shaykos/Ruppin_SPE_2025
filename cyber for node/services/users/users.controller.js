import User from './users.model.js';

export async function getAllUsers(req, res) {
  try {
    let users = await User.getAll();
    if (!users || users.length == 0)
      return res.status(400).json({ message: 'no users found' });
    return res.status(200).json({ message: 'users found', users });
  } catch (error) {
    return res.status(500).json({ message: 'server error' });
  }
}