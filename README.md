# books-for-all-mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Books For All Application

**Members : Maria Helga Grizelda, Raisa Fadilla, Tiva Adhisti, Pascal Pahlevi**

**Introduction:**

A mobile application designed to address the growing crisis of literacy, especially among Gen Z individuals. Inspired by the alarming statistics that indicate a mere 0.001% interest in reading among Indonesians, BooksForAll aims to make reading more accessible and appealing to the younger generation.

**Benefits:**

Encouraging Literacy: BooksForAll seeks to rekindle the love for reading among Gen Z by providing a user-friendly platform that makes discovering and reading books a delightful experience.

Diverse Book Catalog: The application offers a wide range of books spanning various genres, ensuring that users can find something of interest to them, regardless of their preferences.

Personalized Recommendations: The recommendation feature helps users discover books tailored to their tastes and preferences, making their reading journey more engaging.

User-Friendly Interface: BooksForAll boasts an intuitive and aesthetically pleasing user interface, making it easy for users to navigate and enjoy their reading experience.

Wishlist and Collection: Users can create wish lists for books they plan to read and manage their book collections, keeping track of their reading progress.

**Modules/Features:**

1. Authorization & Authentication : Helga
2. Maintain Wishlist : Pascal
3. Write Review/Rating : Helga & Adhis
4. Search Engine : Raisa
5. Write Recommendation : Adhis
6. Book Page : Pascal
7. Sorting by Book Genre : Adhis

**User roles or actors in the application.**

BooksForAll will implement role-based access control with the following user roles:

Registered User: Users with personal accounts. Registered users have personal accounts, allowing them to utilize a wide range of features. They can maintain wishlists, write reviews and ratings, search for books, write recommendations, view detailed book pages, and sort books by genre.

**Integration flow with the web service to connect to the web application created during the Midterm Project.**

To integrate the web services to the web app we would need to setup the authentication on the Django app as well as in the flutter app. More specifically, integrate pbp_django_auth for the flutter app and add http dependency so that data can be fetched from the Django app.


