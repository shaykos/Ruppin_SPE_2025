import { writeFile, appendFile, mkdir } from 'fs/promises';
import { existsSync } from 'fs';
import path from 'path';
import { __dirname } from '../global.js';

export async function writeLogEntry(req, res, next) {

  let clientIP = req.ip || req.connetion.remoteAddress;

  let logFormat = `${clientIP} - ${new Date().toISOString()} - ${req.method} - ${req.host}${req.url} - ${res.statusCode}\n`;
  let logDir = path.join(__dirname, 'logs');
  let logFile = path.join(logDir, `access_${new Date().toISOString().split('T')[0]}.log`);

  try {
    if (!existsSync(logDir)) {
      await mkdir(logDir);
    }

    if (!existsSync(logFile))
      await writeFile(logFile, logFormat);
    else
      await appendFile(logFile, logFormat);

  }
  catch (error) {
    console.log('Error!', error);
  }

  next();
}

export async function writeLogDB(error, data) {

  let func = data.func;
  delete data.func; 

  let logFormat = `${new Date().toISOString()} - ${func} - ${error} - data: ${JSON.stringify(data)}\n`;
  let logDir = path.join(__dirname, 'logs');
  let logFile = path.join(logDir, `access_DB_${new Date().toISOString().split('T')[0]}.log`);

  try {
    if (!existsSync(logDir)) {
      await mkdir(logDir);
    }

    if (!existsSync(logFile))
      await writeFile(logFile, logFormat);
    else
      await appendFile(logFile, logFormat);

  }
  catch (error) {
    console.log('Error!', error);
  }

}




