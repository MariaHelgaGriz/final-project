class Answer {
  final int id;
  final int userId;
  final int questionId;
  final String username;
  final String answer;

  Answer({
    required this.userId,
    required this.questionId,
    required this.id,
    required this.username,
    required this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json, int id) => Answer(
        userId: json['user'],
        questionId: json['question'],
        id: id,
        username: json['username'],
        answer: json['answer'],
      );
}