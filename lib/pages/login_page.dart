import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/pages/dashboard_page.dart';
import 'package:booksforall/pages/register_page.dart';
import 'package:booksforall/source/auth_source.dart';
import 'package:booksforall/widgets/input_basic.dart';
import 'package:booksforall/widgets/input_password.dart';
import 'package:d_button/d_button.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
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
  final loading = ValueNotifier(false);

  login() {
    String username = edtUsername.text;
    String password = edtPassword.text;
    if (username == '') {
      return AppNotif.invalid(context, 'Username must be filled');
    }
    if (password == '') {
      return AppNotif.invalid(context, 'Password must be filled');
    }
    loading.value = true;
    AuthSource.login(username, password).then((result) {
      result.fold(
        (messageFailed) {
          loading.value = false;
          DMethod.log(messageFailed);
          AppNotif.failed(context, messageFailed);
        },
        (messageSuccess) {
          loading.value = false;
          DMethod.log(messageSuccess);
          AppNotif.success(context, messageSuccess);
          Navigator.pushReplacementNamed(context, DashboardPage.route);
        },
      );
    });
  }

  @override
  void dispose() {
    loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Gap(70),
          Center(
            child: Image.asset(
              'assets/logo.png',
              height: 90,
            ),
          ),
          const Gap(60),
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
          ListenableBuilder(
            listenable: loading,
            child: DButtonFlat(
              onClick: () => login(),
              // onClick: () =>
              //     Navigator.pushReplacementNamed(context, DashboardPage.route),
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
            builder: (context, child) {
              if (loading.value) return DView.loadingCircle();
              return child!;
            },
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
        ],
      ),
    );
  }
}
