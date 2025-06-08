import DB from "../../utils/DB.js";

export default class User{
  
  constructor(){

  }
  
  static async getAll(){
    let db = new DB();

    return await db.getDocuments('customers');
    
  }
}