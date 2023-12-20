import '../../models/book.dart';
import 'package:booksforall/models/review.dart';
import 'package:d_button/d_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBookPage extends StatelessWidget {
  static const route = '/book/detail';
  const DetailBookPage({super.key, required this.book});

  final Book book;

  final TextStyle bodyTextStyle = const TextStyle(
    fontSize: 14,
    color: Color(0xffA6A6A6),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Book Description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(
            book.cover,
            height: 300,
            fit: BoxFit.fitHeight,
          ),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
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
              Transform.translate(
                offset: const Offset(0, -10),
                child: IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    AssetImage('assets/ic_wishlist_border.png'),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            book.description,
            style: bodyTextStyle,
          ),
          const Gap(24),
          Text(
            'Review',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          RatingBar.builder(
            initialRating: book.review,
            itemSize: 20,
            allowHalfRating: true,
            unratedColor: Colors.black,
            itemPadding: const EdgeInsets.all(0),
            itemBuilder: (context, index) => const ImageIcon(
              AssetImage('assets/ic_star.png'),
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {},
            ignoreGestures: true,
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: DButtonFlat(
              onClick: () {},
              radius: 30,
              height: 33,
              width: 128,
              mainColor: Theme.of(context).primaryColor,
              child: const Text(
                'Add Review',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Gap(16),
          buildReviewList(),
        ],
      ),
    );
  }

  Widget buildReviewList() {
    final list = [
      Review(
        name: 'Name',
        detail:
            'Review Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.',
      ),
    ];
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Review review = list[0];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Gap(4),
              Text(
                review.detail,
                style: bodyTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
