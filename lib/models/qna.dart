import 'package:booksforall/models/answer.dart';
import 'package:booksforall/models/question.dart';

class QnA {
  final Question question;
  final List<Answer> answerList;

  QnA({required this.question, required this.answerList});

  factory QnA.fromJson(Map<String, dynamic> json) {
    return QnA(
      question: Question.fromJson(
        json['question']['fields'],
        json['question']['pk'],
      ),
      answerList: List.from(
        json['answer_list']
            .map((e) => Answer.fromJson(e['fields'], e['pk']))
            .toList(),
      ),
    );
  }
}