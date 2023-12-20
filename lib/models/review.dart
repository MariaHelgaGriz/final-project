class Review {
  final int id;
  final int userId;
  final int bookId;
  final String review;
  final String username;

  Review({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.review,
    required this.username,
  });

  factory Review.fromJson(Map<String, dynamic> json, int id) => Review(
        id: id,
        review: json['review'],
        userId: json['user'],
        bookId: json['book'],
        username: json['username'],
      );
}
