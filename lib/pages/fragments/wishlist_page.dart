import '../../models/book.dart';
import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
      Book(
        title: 'The Da vinci Code',
        cover: 'assets/item_book.png',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.',
        review: 4.5,
        author: 'author',
        price: 31,
      ),
    ];
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
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          Book book = list[0];
          return Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 0 : 10,
              bottom: index == 10 ? 0 : 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(16),
                Text(
                  book.author,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Gap(16),
                DButtonFlat(
                  onClick: () {},
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
      ),
    );
  }
}
