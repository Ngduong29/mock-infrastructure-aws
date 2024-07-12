document.addEventListener('DOMContentLoaded', function() {
    const apiBaseUrl = '/books';

    const createBookForm = document.getElementById('createBookForm');
    const booksList = document.getElementById('booksList');
    const refreshBooksButton = document.getElementById('refreshBooks');

    // Function to fetch and display all books
    function fetchBooks() {
        fetch(apiBaseUrl)
            .then(response => response.json())
            .then(data => {
                booksList.innerHTML = '';
                data.forEach(book => {
                    const bookDiv = document.createElement('div');
                    bookDiv.classList.add('book');
                    bookDiv.innerHTML = `
                        <p><strong>ID:</strong> ${book.id}</p>
                        <p><strong>Title:</strong> ${book.title}</p>
                        <p><strong>Author:</strong> ${book.author}</p>
                        <p><strong>ISBN:</strong> ${book.isbn}</p>
                        <button onclick="deleteBook(${book.id})">Delete</button>
                    `;
                    booksList.appendChild(bookDiv);
                });
            })
            .catch(error => console.error('Error fetching books:', error));
    }

    // Function to create a new book
    createBookForm.addEventListener('submit', function(event) {
        event.preventDefault();
        
        const formData = new FormData(createBookForm);
        const bookData = {
            title: formData.get('title'),
            author: formData.get('author'),
            isbn: formData.get('isbn')
        };

        fetch(apiBaseUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(bookData)
        })
        .then(response => response.json())
        .then(data => {
            console.log('Book created:', data);
            fetchBooks();
        })
        .catch(error => console.error('Error creating book:', error));
    });

    // Function to delete a book
    window.deleteBook = function(id) {
        fetch(`${apiBaseUrl}/${id}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.status === 204) {
                console.log('Book deleted');
                fetchBooks();
            } else {
                console.error('Error deleting book');
            }
        })
        .catch(error => console.error('Error deleting book:', error));
    };

    // Refresh books list when the button is clicked
    refreshBooksButton.addEventListener('click', fetchBooks);

    // Initial fetch of books
    fetchBooks();
});