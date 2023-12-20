import 'package:booksforall/pages/dashboard_page.dart';
import 'package:booksforall/pages/detail_book_page.dart';
import 'package:booksforall/pages/intro_page.dart';
import 'package:booksforall/pages/login_page.dart';
import 'package:booksforall/pages/register_page.dart';
import 'package:booksforall/pages/search_page.dart';
import 'package:flutter/material.dart';

import 'models/book.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff4D918F),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff4D918F),
        ),
      ),
      home: const IntroPage(),
      routes: {
        LoginPage.route: (context) => const LoginPage(),
        RegisterPage.route: (context) => const RegisterPage(),
        DashboardPage.route: (context) => const DashboardPage(),
        SearchPage.route: (context) => const SearchPage(),
        DetailBookPage.route: (context) {
          Book book = ModalRoute.of(context)?.settings.arguments as Book;
          return DetailBookPage(book: book);
        },
      },
    );
  }
}
