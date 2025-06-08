import { writeLogDB, writeLogEntry } from "./log.js";

export function errorHandler(err, req, res, next) {
  console.error(err.message);
  writeLogEntry(req, res);
  writeLogDB(err, { req, res })
  //res.status(500).json({error: err.message});
};