import { MongoClient, ObjectId } from 'mongodb';
import { writeLogDB } from '../middleware/log.js'

export default class DB {
  client = null;
  dbName = null;

  constructor() {
    this.client = new MongoClient(process.env.MONGODB_URI);
    this.dbName = process.env.DB_NAME;
  }

  async addDocument(collection, doc) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).insertOne(doc);
    } catch (error) {
      writeLogDB(error, { func: 'addDocument', collection, doc });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }


  async addDocuments(collection, docs) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).insertMany(docs);
    } catch (error) {
      writeLogDB(error, { func: 'addDocuments', collection, docs });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }


  async getDocumentById(collection, id, projection = {}) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).findOne({ _id: ObjectId.createFromHexString(id) }, { projection });
    } catch (error) {
      writeLogDB(error, { func: 'getDocumentById', collection, id, projection });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }


  async getDocuments(collection, filter = {}, projection = {}) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).find(filter, { projection }).toArray();
    } catch (error) {
      writeLogDB(error, { func: 'getDocuments', collection, filter, projection });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }

  async updateDocument(collection, id, doc) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).updateOne({ _id: ObjectId.createFromHexString(id) }, { $set: doc });
    } catch (error) {
      writeLogDB(error, { func: 'updateDocument', collection, id, doc });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }

  async aggregateDocuments(collection, pipeline = []) {
    try {
      await this.client?.connect();
      return await this.client.db(this.dbName).collection(collection).aggregate(pipeline).toArray();
    } catch (error) {
      writeLogDB(error, { func: 'aggregateDocuments', collection, pipeline });
      console.log('error', error)
    }
    finally {
      await this.client?.close();
    }
  }


}