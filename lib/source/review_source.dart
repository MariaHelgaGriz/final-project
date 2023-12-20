import 'dart:convert';
import 'package:booksforall/common/api.dart';
import 'package:booksforall/models/review.dart';
import 'package:booksforall/models/user.dart';
import 'package:d_method/d_method.dart';
import 'package:d_session/d_session.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ReviewSource {
  static Future<Either<String, List<Review>>> all(int bookId) async {
    String url = '${Api.host}/api/v1/get/get_review/$bookId';
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
        List list = resBody['review_list'];
        return Right(
          list.map((e) {
            int id = e['pk'];
            final review = e['fields'];
            return Review.fromJson(review, id);
          }).toList(),
        );
      }
      return const Left('Server error');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> add(int bookId, String review) async {
    String url = '${Api.host}/api/v1/add/create_review/';
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
          'reviewForm': bookId.toString(),
          'review': review,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        Map resBody = jsonDecode(response.body);
        String message = resBody['message'];
        return Right(message);
      }
      return const Left('Failed Add Review');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }
}
