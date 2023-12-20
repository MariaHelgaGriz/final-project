import 'package:booksforall/models/user.dart';
import 'package:booksforall/pages/dashboard_page.dart';
import 'package:booksforall/pages/login_page.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const route = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = User.init.obs;

  logout() {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure want to logout?',
    ).then((yes) {
      if (yes ?? false) {
        DSession.removeCustom('username');
        DSession.removeCustom('session_id');
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginPage.route,
          (route) => route.settings.name == DashboardPage.route,
        );
      }
    });
  }

  @override
  void initState() {
    DSession.getUser().then((value) {
      if (value == null) return;
      user.value = User.fromJson(Map.from(value));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          const Gap(8),
          Divider(color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: 56,
                  height: 56,
                ),
                const Gap(16),
                Expanded(
                  child: Obx(() {
                    return Text(user.value.username);
                  }),
                ),
                GestureDetector(
                  onTap: logout,
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[300]),
        ],
      ),
    );
  }
}