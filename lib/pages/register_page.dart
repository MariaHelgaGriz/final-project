import 'package:booksforall/widgets/input_basic.dart';
import 'package:booksforall/widgets/input_password.dart';
import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_notif.dart';
import '../source/auth_source.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const route = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final edtUsername = TextEditingController();
  final edtPassword = TextEditingController();
  final loading = ValueNotifier(false);

  register() {
    // if dummmy, use this:
    // Navigator.pushReplacementNamed(context, DashboardPage.route);
    //
    // not this:
    String username = edtUsername.text;
    String password = edtPassword.text;
    if (username == '') {
      return AppNotif.invalid(context, 'Username must be filled');
    }
    if (password == '') {
      return AppNotif.invalid(context, 'Password must be filled');
    }
    loading.value = true;
    AuthSource.register(
      edtUsername.text,
      edtPassword.text,
    ).then((result) {
      result.fold(
        (messageFailed) {
          loading.value = false;
          AppNotif.failed(context, messageFailed);
        },
        (messageSuccess) {
          loading.value = false;
          AppNotif.success(context, messageSuccess);
          Navigator.pop(context); // back to LoginPage
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Gap(30),
          Transform.translate(
            offset: const Offset(-16, 0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: BackButton(),
            ),
          ),
          Text(
            'Register',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Text(
            'Create account',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffA6A6A6),
            ),
          ),
          const Gap(30),
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
              onClick: () => register(),
              radius: 30,
              height: 48,
              mainColor: Theme.of(context).primaryColor,
              child: const Text(
                'Register',
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
                'Have an account? ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Login',
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
