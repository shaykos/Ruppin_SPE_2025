import Book from './books.model.js';

export async function getBooks(req, res) {
    try {
        const books = await Book.findAll();
        return res.status(200).json(books);
    } catch (error) {
        return res.status(500).json({ error: 'An error occurred while fetching books.' });
    }
}

export async function getBookById(req, res) {
    let { id } = req.params;
    //בדיקה על הפרמטר שהתקבל
    if (!id) {
        return res.status(400).json({ error: 'Book ID is required.' });
    }

    if (!ObjectId.isValid(id)) {
        return res.status(400).json({ error: 'Invalid Book ID.' });
    }

    //בקשה לשליפת נתונים
    try {
        const book = await Book.findById(id);
        if (!book) {
            return res.status(404).json({ error: 'Book not found.' });
        }
        return res.status(200).json(book);
    } catch (error) {
        return res.status(500).json({ error: 'An error occurred while fetching the book.' });
    }
}

export async function addBook(req, res) {
    let { title, author, genre, publishedYear } = req.body;
    console.log(title, author, genre, publishedYear);

    //בדיקה על הפרמטרים שהתקבלו
    if (!title || !author || !genre || !publishedYear) {
        return res.status(400).json({ error: 'All fields are required.' });
    }
    //יצירת אובייקט ספר חדש
    const newBook = new Book(title, author, genre, publishedYear);
    //בקשה להוספת ספר חדש
    try {
        const result = await newBook.save();
        return res.status(201).json(result);
    } catch (error) {
        return res.status(500).json({ error: 'An error occurred while adding the book.' });
    }
}

export async function updateBook(req, res) {
    let { id } = req.params;
    let { title, author, genre, publishedYear } = req.body;
    //בדיקה על הפרמטרים שהתקבלו
    if (!id) {
        return res.status(400).json({ error: 'Book ID is required.' });
    }
    if (!ObjectId.isValid(id)) {
        return res.status(400).json({ error: 'Invalid Book ID.' });
    }
    if (!title || !author || !genre || !publishedYear) {
        return res.status(400).json({ error: 'All fields are required.' });
    }
    //יצירת אובייקט ספר חדש
    const updatedBook = new Book(title, author, genre, publishedYear);

    //בקשה לעדכון ספר קיים
    try {
        const result = await updatedBook.update(id);
        return res.status(200).json(result);
    } catch (error) {
        return res.status(500).json({ error: 'An error occurred while updating the book.' });
    }

}

export async function deleteBook(req, res) {
    let { id } = req.params;
    //בדיקה על הפרמטר שהתקבל
    if (!id) {
        return res.status(400).json({ error: 'Book ID is required.' });
    }
    if (!ObjectId.isValid(id)) {
        return res.status(400).json({ error: 'Invalid Book ID.' });
    }
    //בקשה למחיקת ספר
    try {
        const result = await Book.delete(id);
        return res.status(200).json(result);
    } catch (error) {
        return res.status(500).json({ error: 'An error occurred while deleting the book.' });
    }
}