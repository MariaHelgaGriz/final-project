import '../../models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  final categories = ['All', 'Romance', 'Horror', 'Fiction', 'Comic'];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Welcome Back, Username!',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(20),
          buildPageView(),
          const Gap(20),
          DefaultTabController(
            length: categories.length,
            child: TabBar(
              padding: const EdgeInsets.only(left: 16, right: 16),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              tabs: categories.map((e) => Tab(text: e)).toList(),
            ),
          ),
          const Gap(20),
          buildGridViewBooks(),
        ],
      ),
    );
  }

  Widget buildGridViewBooks() {
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
    return GridView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        Book book = list[0];
        return GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/item_book.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(8),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                book.author,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Column buildPageView() {
    return Column(
      children: [
        SizedBox(
          height: 145,
          child: PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xffD6E4DE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 30, 8, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The Trials of Apollo',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Rick Riordian',
                            ),
                            const Gap(8),
                            RatingBar.builder(
                              initialRating: 4,
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
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/item_book.png',
                        height: 145,
                        width: 99,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Gap(8),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Theme.of(context).primaryColor,
              dotColor: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }
}
