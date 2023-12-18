import '../../models/fragment.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const route = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final index = ValueNotifier(0);

  final fragments = [
    Fragment(
      label: 'Home',
      icon: 'assets/ic_home.png',
      view: const Scaffold(),
    ),
    Fragment(
      label: 'Wishlist',
      icon: 'assets/ic_wishlist.png',
      view: const Scaffold(),
    ),
    Fragment(
      label: 'Cart',
      icon: 'assets/ic_cart.png',
      view: const Scaffold(),
    ),
    Fragment(
      label: 'QnA',
      icon: 'assets/ic_qna.png',
      view: const Scaffold(),
    ),
  ];

  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: index,
        builder: (context, child) {
          return fragments[index.value].view;
        },
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: index,
        builder: (context, child) {
          return BottomNavigationBar(
            currentIndex: index.value,
            onTap: (n) => index.value = n,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: fragments.map((e) {
              return BottomNavigationBarItem(
                label: e.label,
                icon: ImageIcon(
                  AssetImage(e.icon),
                  // color: Colors.grey,
                ),
                activeIcon: ImageIcon(
                  AssetImage(e.icon),
                  // color: Theme.of(context).primaryColor,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
