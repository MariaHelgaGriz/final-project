import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/wishlist.dart';
import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/wishlist_controller.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    wishlistController.fetchWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        FetchState state = wishlistController.status.state;
        if (state == FetchState.init) {
          return DView.nothing();
        }
        if (state == FetchState.loading) {
          return DView.loadingCircle();
        }
        if (state == FetchState.failed) {
          return DView.error(data: wishlistController.status.message);
        }
        List<Wishlist> wishlists = wishlistController.wishlists;
        if (wishlists.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/wishlist_empty.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                const Gap(16),
                const Text('There is no wishlist'),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: wishlists.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            Wishlist wishlist = wishlists[index];
            return Padding(
              padding: EdgeInsets.only(
                top: index == 1 ? 0 : 10,
                bottom: index == 10 ? 0 : 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      wishlist.bookTitle,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    wishlist.author,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Gap(16),
                  DButtonFlat(
                    onClick: () {
                      wishlistController.deleteItemWishlist(
                        wishlist.bookId,
                        context,
                      );
                    },
                    radius: 30,
                    height: 23,
                    width: 46,
                    mainColor: const Color(0xffEB1717),
                    child: const ImageIcon(
                      AssetImage('assets/ic_close.png'),
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
