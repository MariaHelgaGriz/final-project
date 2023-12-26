import 'package:booksforall/pages/dashboard_page.dart';
import 'package:booksforall/pages/detail_book_page.dart';
import 'package:booksforall/pages/intro_page.dart';
import 'package:booksforall/pages/login_page.dart';
import 'package:booksforall/pages/profile_page.dart';
import 'package:booksforall/pages/register_page.dart';
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
        scaffoldBackgroundColor: const Color(0xffF5F5F5),
      ),
      home: const IntroPage(),
      // home: DetailBookPage(
      //   book: Book(
      //     id: 1,
      //     title: 'title',
      //     url:
      //         'https://images.pexels.com/photos/17258048/pexels-photo-17258048/free-photo-of-close-up-of-stones-on-ground.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      //     description: 'description',
      //     genre: 'genre',
      //     author: 'author',
      //     rating: 4.5,
      //   ),
      // ),
      // home: DashboardPage(),
      routes: {
        LoginPage.route: (context) => const LoginPage(),
        RegisterPage.route: (context) => const RegisterPage(),
        DashboardPage.route: (context) => const DashboardPage(),
        ProfilePage.route: (context) => const ProfilePage(),
        DetailBookPage.route: (context) {
          Book book = ModalRoute.of(context)?.settings.arguments as Book;
          return DetailBookPage(book: book);
        },
      },
    );
  }
}
