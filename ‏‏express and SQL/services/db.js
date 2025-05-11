import sql from 'mssql';

export default class DB {

  static sqlConfig = {
    user: process.env.DB_USER,
    password: process.env.DB_PWD,
    database: process.env.DB_NAME,
    server: process.env.DB_SERVER,
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000
    },
    options: {
      encrypt: false, // true for azure
      trustServerCertificate: true //false for local
    }
  }

  static async selectData(query) {
    try {
      const pool = await sql.connect(DB.sqlConfig);
      const result = await pool.request().query(query);
      return result.recordset;
    } catch (err) {
      console.log(err);
    }
  }

  static async insert(procName, data) {
    try {
      const pool = await sql.connect(DB.sqlConfig);

      let request = new sql.Request();
      
      for (const [key, value] of Object.entries(data)) {
        request.input(key, value)
      }

      return await pool.request(request).execute(procName);

    } catch (err) {
      console.log(err);
    }
  }
}