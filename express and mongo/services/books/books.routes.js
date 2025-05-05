import { getBooks, getBookById, addBook, updateBook, deleteBook } from "./books.controller.js";
import { Router } from "express";

const booksRouter = Router();

// // GET /books
// router.get("/", getBooks);

// // GET /books/:id
// router.get("/:id", getBookById);

// // POST /books
// router.post("/", addBook);

// // PUT /books/:id
// router.put("/:id", updateBook);

// // DELETE /books/:id
// router.delete("/:id", deleteBook);

booksRouter
    .get('/', getBooks)
    .get('/:id', getBookById)
    .post('/', addBook)
    .put('/:id', updateBook)
    .delete('/:id', deleteBook);

// Export the router
export default booksRouter;