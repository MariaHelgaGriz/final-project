import 'dart:convert';

import 'package:booksforall/common/api.dart';
import 'package:booksforall/models/book.dart';
import 'package:booksforall/models/user.dart';
import 'package:d_method/d_method.dart';
import 'package:d_session/d_session.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CartSource {
  static Future<Either<String, List<Book>>> all() async {
    String url = '${Api.host}/api/v1/get/get_cart/';
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
        List list = resBody['cart_list'];
        return Right(
          list.map((e) {
            int id = e['pk'];
            final book = e['fields'];
            return Book.fromJson(book, id);
          }).toList(),
        );
      }
      return const Left('Server Error');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> add(int bookId) async {
    String url = '${Api.host}/api/v1/add/create_cart/';
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
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        Map resBody = jsonDecode(response.body);
        String message = resBody['message'];
        return Right(message);
      }
      return const Left('Failed Add Book to Cart');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> delete(int bookId) async {
    String url = '${Api.host}/api/v1/remove/remove_cart/$bookId';
    try {
      final userMap = await DSession.getUser();
      User user = User.fromJson(userMap);
      String sessionId = user.sessionId;
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Cookie': 'sessionid=$sessionId',
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 202) {
        Map resBody = jsonDecode(response.body);
        String message = resBody['message'];
        return Right(message);
      }
      return const Left('Failed Delete Book from Cart');
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }
}
