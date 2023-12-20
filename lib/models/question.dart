class Question {
  final int id;
  final int userId;
  final int book;
  final String bookTitle;
  final String question;

  Question({
    required this.userId,
    required this.book,
    required this.bookTitle,
    required this.id,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json, int id) => Question(
        userId: json['user'],
        book: json['book'],
        bookTitle: json['book_title'],
        id: id,
        question: json['question'],
      );
}