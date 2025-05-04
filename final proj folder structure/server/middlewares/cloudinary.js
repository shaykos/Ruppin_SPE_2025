import { v2 as cloudinary } from 'cloudinary';
import {readdirSync, unlinkSync} from 'fs';
import path from 'path';

cloudinary.config({
  cloud_name: process.env.CLOUDNIARY_CLOUD_NAME,
  api_key: process.env.CLOUDNIARY_API_KEY,
  api_secret: process.env.CLOUDNIARY_API_SECRET
});

function removeAllFilesSync(directory) {
    const files = readdirSync(directory);
    
    for (const file of files) {
        const filePath = path.join(directory, file);
        unlinkSync(filePath);
    }
}

export async function uploadToCloudinary(req, res, next) {
  try {
    let result = await cloudinary.uploader.upload(req.file.path, { upload_preset: process.env.CLOUDNIARY_PRESET_NAME });
    removeAllFilesSync('uploads');
    req.cloudinary = result;
    next();
  } catch (error) {
    res.status(500).json(error);
  }
}