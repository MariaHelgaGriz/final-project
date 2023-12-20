import 'dart:convert';

import 'package:booksforall/common/api.dart';
import 'package:d_method/d_method.dart';
import 'package:d_session/d_session.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthSource {
  static Future<Either<String, String>> login(
    String username,
    String password,
  ) async {
    String url = '${Api.host}/api/v1/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'password': password,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        Map userMap = jsonDecode(response.body);
        await DSession.setUser(userMap);
        return const Right('Login Success');
      } else {
        return const Left('Login Failed');
      }
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }

  static Future<Either<String, String>> register(
    String username,
    String password,
  ) async {
    String url = '${Api.host}/api/v1/register/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'password': password,
        },
      );
      DMethod.logResponse(response);

      if (response.statusCode == 201) {
        return const Right('Register Success');
      } else {
        return const Left('Register Failed');
      }
    } catch (e) {
      DMethod.log(e.toString());
      return const Left('Something went wrong');
    }
  }
}
