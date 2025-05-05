import { getAllBooksFromDatabase, getBookById, saveBookToDatabase, updateBookInDatabase, deleteBookInDatabase } from './books.db.js';

export default class Book {
    constructor(title, author, genre, publishedYear) {
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.publishedYear = publishedYear;
    }

    static async findAll() {
        try {
            return await getAllBooksFromDatabase(); // fetching from a database 
        } catch (error) {
            throw new Error('An error occurred while fetching books.');
        }
    }

    static async findById(id) {
        try {
            return await getBookById(id); // fetching from a database
        } catch (error) {
            throw new Error('An error occurred while fetching the book.');
        }
    }

    static async delete(id) {
        try {
            return await deleteBookInDatabase(id); // deleting from a database
        } catch (error) {
            throw new Error('An error occurred while deleting the book.');
        }
    }

    async save() {
        try {
            return await saveBookToDatabase(this); // saving to a database
        } catch (error) {
            throw new Error('An error occurred while saving the book.');
        }
    }

    async update(id) {
        try {
            return await updateBookInDatabase(this, id); // updating in a database
        } catch (error) {
            throw new Error('An error occurred while updating the book.');
        }
    }
}