import 'package:booksforall/controllers/cart_controller.dart';
import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../common/enum.dart';
import '../../models/book.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    cartController.fetchCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              FetchState state = cartController.status.state;
              if (state == FetchState.init) {
                return DView.nothing();
              }
              if (state == FetchState.loading) {
                return DView.loadingCircle();
              }
              if (state == FetchState.failed) {
                return DView.error(data: cartController.status.message);
              }
              List<Book> books = cartController.books;
              if (books.isEmpty) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/cart_empty.png',
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                      const Gap(16),
                      const Text('There is no products'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ExtendedImage.network(
                            book.url,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                book.author,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(16),
                        IconButton(
                          onPressed: () {
                            cartController.deleteItemCart(book.id, context);
                          },
                          icon: const ImageIcon(
                            AssetImage('assets/ic_delete.png'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: DButtonFlat(
              onClick: () => buildGotoPayment(),
              radius: 30,
              height: 48,
              mainColor: Theme.of(context).primaryColor,
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildGotoPayment() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).primaryColor,
          contentPadding: const EdgeInsets.fromLTRB(24, 34, 24, 30),
          children: [
           
            ),
            const Gap(30),
            DButtonFlat(
              height: 49,
              radius: 30,
              onClick: () => Navigator.pop(context),
              child: const Text(
                'Go to Payment Page',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
