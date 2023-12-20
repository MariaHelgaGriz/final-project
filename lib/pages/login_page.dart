import 'package:booksforall/pages/dashboard_page.dart';
import 'package:booksforall/pages/register_page.dart';
import 'package:booksforall/widgets/input_basic.dart';
import 'package:booksforall/widgets/input_password.dart';
import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final edtUsername = TextEditingController();
  final edtPassword = TextEditingController();

  login() {
    Navigator.pushReplacementNamed(context, DashboardPage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(MediaQuery.of(context).padding.top),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 90,
                    ),
                  ),
                  const Gap(50),
                  Text(
                    'Welcome 👋',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'Sign to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffA6A6A6),
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  InputBasic(
                    editingController: edtUsername,
                    hint: 'Your Username',
                  ),
                  const Gap(20),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  InputPassword(
                    editingController: edtPassword,
                    hint: 'Your Password',
                  ),
                  const Gap(30),
                  DButtonFlat(
                    onClick: () => login(),
                    radius: 30,
                    height: 48,
                    mainColor: Theme.of(context).primaryColor,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.route);
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Gap(16),
                      Text(
                        'Or with',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Gap(16),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  DButtonBorder(
                    onClick: () {},
                    radius: 30,
                    borderWidth: 1,
                    borderColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/ic_google.png'),
                        const Gap(16),
                        const Text('Sign in with Google'),
                      ],
                    ),
                  ),
                  const Gap(10),
                  DButtonBorder(
                    onClick: () {},
                    radius: 30,
                    borderWidth: 1,
                    borderColor: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/ic_apple.png'),
                        const Gap(16),
                        const Text('Sign in with Apple'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
