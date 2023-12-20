class Question {
  final int id;
  final int userId;
  final int bookId;
  final String question;

  Question({
    required this.userId,
    required this.bookId,
    required this.id,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json, int id) => Question(
        userId: json['user'],
        bookId: json['book'],
        id: id,
        question: json['question'],
      );
}