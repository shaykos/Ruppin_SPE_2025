import { singleFileToStorage, multipleFilesToStorage } from './upload.controller.js';
import { Router } from "express";
import { upload } from '../../globals.js';
import { uploadToCloudinary } from '../../middlewares/cloudinary.js'


const uploadRouter = Router();

uploadRouter
  .post('/single', upload.single('file'), singleFileToStorage)
  .post('/files', upload.array('files', 5), multipleFilesToStorage)
  .post('/cloud', upload.single('file'), uploadToCloudinary, (req, res) => {
    res.json(req.cloudinary);
  })

export default uploadRouter;