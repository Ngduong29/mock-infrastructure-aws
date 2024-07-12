package com.example.demo;

import lombok.extern.log4j.Log4j2;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@Log4j2
public class HomeController {

    private List<Book> books = new ArrayList<>();

    @GetMapping("/home/{name}")
    public String home(@PathVariable String name) {
        log.info("Request with name {}", name);
        return "Home " + name;
    }

    @GetMapping("/{name}")
    public String hello(@PathVariable String name) {
        log.info("Request with name {}", name);
        return "Heyyy Hello there 123334444" + name;
    }

    // Get all books
    @GetMapping("/books")
    public List<Book> getAllBooks() {
        log.info("Getting all books");
        return books;
    }

    // Get a book by id
    @GetMapping("/books/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        log.info("Getting book with id {}", id);
        Optional<Book> book = books.stream().filter(b -> b.getId().equals(id)).findFirst();
        return book.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new book
    @PostMapping("/books")
    public Book createBook(@RequestBody Book book) {
        log.info("Creating book with title {}", book.getTitle());
        book.setId((long) (books.size() + 1));
        books.add(book);
        return book;
    }

    // Update an existing book
    @PutMapping("/books/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Long id, @RequestBody Book bookDetails) {
        log.info("Updating book with id {}", id);
        Optional<Book> book = books.stream().filter(b -> b.getId().equals(id)).findFirst();
        if (book.isPresent()) {
            Book updatedBook = book.get();
            updatedBook.setTitle(bookDetails.getTitle());
            updatedBook.setAuthor(bookDetails.getAuthor());
            updatedBook.setIsbn(bookDetails.getIsbn());
            return new ResponseEntity<>(updatedBook, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a book
    @DeleteMapping("/books/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        log.info("Deleting book with id {}", id);
        if (books.removeIf(book -> book.getId().equals(id))) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/")
    public String index() {
        return "<!DOCTYPE html>" +
                "<html lang=\"en\">" +
                "<head>" +
                "    <meta charset=\"UTF-8\">" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" +
                "    <title>Book Management</title>" +
                "    <link rel=\"stylesheet\" href=\"styles.css\">" +
                "</head>" +
                "<body>" +
                "    <h1>Book Management</h1>" +
                "    <section>" +
                "        <h2>Create Book</h2>" +
                "        <form id=\"createBookForm\">" +
                "            <label for=\"title\">Work:</label>" +
                "            <input type=\"text\" id=\"title\" name=\"Work\" required><br>" +
                "            <label for=\"author\">Category:</label>" +
                "            <input type=\"text\" id=\"author\" name=\"Category\" required><br>" +
                "            <label for=\"isbn\">Date2:</label>" +
                "            <input type=\"text\" id=\"isbn\" name=\"Date2\" required><br>" +
                "            <button type=\"submit\">Create Book</button>" +
                "        </form>" +
                "    </section>" +
                "    <section>" +
                "        <h2>Books List</h2>" +
                "        <button id=\"refreshBooks\">Refresh Books</button>" +
                "        <div id=\"booksList\"></div>" +
                "    </section>" +
                "    <script src=\"scripts.js\"></script>" +
                "</body>" +
                "</html>";
    }

    // Book class
    static class Book {
        private Long id;
        private String title;
        private String author;
        private String isbn;

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getAuthor() {
            return author;
        }

        public void setAuthor(String author) {
            this.author = author;
        }

        public String getIsbn() {
            return isbn;
        }

        public void setIsbn(String isbn) {
            this.isbn = isbn;
        }
    }

}
