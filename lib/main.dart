import '/pages/fragments/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'models/book.dart';
import '/pages/intro_page.dart';

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
        DashboardPage.route: (context) => const DashboardPage(),
      },
    );
  }
}
