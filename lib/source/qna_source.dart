import 'dart:convert';
import 'package:booksforall/models/question.dart';
import 'package:d_method/d_method.dart';
import 'package:d_session/d_session.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class QnaSource {
  static Future<Either<String, List<Question>>> all() async {
    String url = 'http://127.0.0.1:8000/api/v1/get/get_question_answer/';
    try {
      String sessionId = await DSession.getCustom('session_id');
      final response = await http.get(Uri.parse(url), headers: {
        'cookie': sessionId,
      });
      DMethod.logResponse(response);

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        List list = resBody['question_answer_list'];
        return Right(
          list.map((e) {
            int id = e['pk'];
            final question = e['fields'];
            return Question.fromJson(question, id);
          }).toList(),
        );
      }
      return const Left('Server error');
    } catch (e) {
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> addQuestion(
      String bookId, String question) async {
    String url = 'http://127.0.0.1:8000/api/v1/add/create_question/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'bookId': bookId,
          'question': question,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        return const Right('Success Add Question');
      }
      return const Left('Failed Add Question');
    } catch (e) {
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> addAnswer(
    String questionId,
    String answer,
  ) async {
    String url = 'http://127.0.0.1:8000/api/v1/add/create_answer/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'questionId': questionId,
          'answer': answer,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        return const Right('Success Add Answer');
      }
      return const Left('Failed Add Answer');
    } catch (e) {
      return const Left('Something went wrong');
    }
  }
}