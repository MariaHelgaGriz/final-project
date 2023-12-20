class Wishlist {
  final int id;
  final int bookId;
  final int userId;
  final String bookTitle;
  final String author;
  Wishlist({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.bookTitle,
    required this.author,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json, int id) {
    return Wishlist(
      id: id,
      bookId: json['book'],
      userId: json['user'],
      bookTitle: json['book_title'],
      author: json['author'],
    );
  }
}
