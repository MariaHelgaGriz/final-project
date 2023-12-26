import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/controllers/detail_controller.dart';
import 'package:booksforall/models/book.dart';
import 'package:booksforall/models/review.dart';
import 'package:d_button/d_button.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBookPage extends StatefulWidget {
  static const route = '/book/detail';
  const DetailBookPage({super.key, required this.book});

  final Book book;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  final detailController = Get.put(DetailController());

  @override
  void initState() {
    detailController.checkWishlist(widget.book.id);
    detailController.fetchReviews(widget.book.id);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DetailController>(force: true);
    super.dispose();
  }

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
          ExtendedImage.network(
            widget.book.url,
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
                      widget.book.title,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      widget.book.author,
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
                  onPressed: () {
                    detailController.addDeleteWishlist(widget.book.id, context);
                  },
                  icon: Obx(() {
                    bool isWishlist = detailController.isWishlist;
                    if (isWishlist) {
                      return const ImageIcon(
                        AssetImage('assets/ic_wishlist.png'),
                        color: Colors.red,
                      );
                    }
                    return const ImageIcon(
                      AssetImage('assets/ic_wishlist_border.png'),
                      color: Colors.grey,
                    );
                  }),
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            widget.book.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xffA6A6A6),
            ),
          ),
          const Gap(24),
          Row(
            children: [
              DButtonFlat(
                onClick: () {
                  detailController.addToCart(widget.book.id, context);
                },
                radius: 30,
                height: 33,
                width: 128,
                mainColor: Theme.of(context).primaryColor,
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(20),
              DButtonFlat(
                onClick: () => buildInputAsk(),
                radius: 30,
                height: 33,
                width: 67,
                mainColor: Theme.of(context).primaryColor,
                child: const Text(
                  'Ask',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Gap(30),
          Text(
            'Review',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          RatingBar.builder(
            initialRating: widget.book.rating,
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
              onClick: () => buildInputAddReview(),
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

  buildInputAsk() {
    final edtQuestion = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DInput(
                controller: edtQuestion,
                fillColor: Colors.white,
                hint: 'type question here...',
                radius: BorderRadius.circular(10),
              ),
              const Gap(16),
              DButtonFlat(
                onClick: () {
                  if (edtQuestion.text == '') {
                    return AppNotif.toastInvalid(
                      context,
                      'Question must be filled',
                    );
                  }
                  Navigator.pop(context);
                  detailController.ask(
                    widget.book.id,
                    edtQuestion.text,
                    context,
                  );
                },
                radius: 30,
                height: 33,
                width: 128,
                mainColor: Theme.of(context).primaryColor,
                child: const Text(
                  'Ask',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        );
      },
    );
  }

  buildInputAddReview() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      builder: (context) {
        final edtReview = TextEditingController();
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DInput(
                controller: edtReview,
                fillColor: Colors.white,
                hint: 'type review here...',
                radius: BorderRadius.circular(10),
              ),
              const Gap(16),
              DButtonFlat(
                onClick: () {
                  if (edtReview.text == '') {
                    return AppNotif.toastInvalid(
                      context,
                      'Review must be filled',
                    );
                  }
                  Navigator.pop(context);
                  detailController.addReview(
                    widget.book.id,
                    edtReview.text,
                    context,
                  );
                },
                radius: 30,
                height: 33,
                width: 128,
                mainColor: Theme.of(context).primaryColor,
                child: const Text(
                  'Add review',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        );
      },
    );
  }

  Widget buildReviewList() {
    return Obx(() {
      FetchState state = detailController.status.state;
      if (state == FetchState.init) {
        return DView.nothing();
      }
      if (state == FetchState.loading) {
        return DView.loadingCircle();
      }
      if (state == FetchState.failed) {
        return DView.error(data: detailController.status.message);
      }
      List<Review> reviews = detailController.reviews;
      if (reviews.isEmpty) {
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/cart_empty.png',
            //   width: 250,
            //   height: 250,
            //   fit: BoxFit.cover,
            // ),
            // const Gap(16),
            Text('There is no review'),
          ],
        );
      }
      return ListView.separated(
        itemCount: reviews.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
          );
        },
        itemBuilder: (context, index) {
          Review review = reviews[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Gap(4),
              Text(
                review.review,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffA6A6A6),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
