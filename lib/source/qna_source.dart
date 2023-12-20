import 'dart:convert';
import 'package:booksforall/common/api.dart';
import 'package:booksforall/models/qna.dart';
import 'package:booksforall/models/user.dart';
import 'package:d_method/d_method.dart';
import 'package:d_session/d_session.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class QnaSource {
  static Future<Either<String, List<QnA>>> all() async {
    String url = '${Api.host}/api/v1/get/get_question_answer/';
    try {
      final userMap = await DSession.getUser();
      User user = User.fromJson(userMap);
      String sessionId = user.sessionId;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Cookie': 'sessionid=$sessionId',
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        List list = resBody['question_answer_list'];
        return Right(
          list.map((e) => QnA.fromJson(e)).toList(),
        );
      }
      return const Left('Server error');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> addQuestion(
    int bookId,
    String question,
  ) async {
    String url = '${Api.host}/api/v1/add/create_question/';
    try {
      final userMap = await DSession.getUser();
      User user = User.fromJson(userMap);
      String sessionId = user.sessionId;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Cookie': 'sessionid=$sessionId',
        },
        body: {
          'bookid': bookId.toString(),
          'question': question,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        Map resBody = jsonDecode(response.body);
        String message = resBody['message'];
        return Right(message);
      }
      return const Left('Failed Add Question');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> addAnswer(
    int questionId,
    String answer,
  ) async {
    String url = '${Api.host}/api/v1/add/create_answer/';
    try {
      final userMap = await DSession.getUser();
      User user = User.fromJson(userMap);
      String sessionId = user.sessionId;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Cookie': 'sessionid=$sessionId',
        },
        body: {
          'questionid': questionId.toString(),
          'answer': answer,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        Map resBody = jsonDecode(response.body);
        String message = resBody['message'];
        return Right(message);
      }
      return const Left('Failed Add Question');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }
}