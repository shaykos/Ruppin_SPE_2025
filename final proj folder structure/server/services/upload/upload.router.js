import { Router } from "express";
import { upload } from '../../globals.js';

const uploadRouter = Router();

uploadRouter
  .post('/single', upload.single('file'), async (req, res) => {
    console.log('file --> ', req.file);
    res.end();
  })
  .post('/files', upload.array('files', 5), async (req, res) => {
    console.log(req.files);
    res.end();
  })

export default uploadRouter;