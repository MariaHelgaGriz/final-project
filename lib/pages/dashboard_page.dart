import 'package:booksforall/models/fragment.dart';
import 'package:booksforall/pages/fragments/cart_page.dart';
import 'package:booksforall/pages/fragments/home_page.dart';
import 'package:booksforall/pages/fragments/qna_page.dart';
import 'package:booksforall/pages/fragments/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const route = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final indexFragment = 0.obs;

  final fragments = [
    Fragment(
      label: 'Home',
      icon: 'assets/ic_home.png',
      view: const HomePage(),
    ),
    Fragment(
      label: 'Wishlist',
      icon: 'assets/ic_wishlist.png',
      view: const WishlistPage(),
    ),
    Fragment(
      label: 'Cart',
      icon: 'assets/ic_cart.png',
      view: const CartPage(),
    ),
    Fragment(
      label: 'QnA',
      icon: 'assets/ic_qna.png',
      view: const QnaPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return fragments[indexFragment.value].view;
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            currentIndex: indexFragment.value,
            onTap: (n) => indexFragment.value = n,
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
