import 'package:booksforall/common/enum.dart';
import 'package:booksforall/controllers/home_controller.dart';
import 'package:booksforall/models/book.dart';
import 'package:booksforall/models/user.dart';
import 'package:booksforall/pages/detail_book_page.dart';
import 'package:booksforall/pages/profile_page.dart';
import 'package:d_button/d_button.dart';
import 'package:d_session/d_session.dart';
import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  final categories = ['All', 'Romance', 'Thriller', 'Fiction', 'Comedy'];
  final homeController = Get.put(HomeController());
  final user = User.init.obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.fetchBooks();
    });

    DSession.getUser().then((value) {
      if (value == null) return;
      user.value = User.fromJson(Map.from(value));
    });
    super.initState();
  }

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfilePage.route);
            },
            icon: const ImageIcon(
              AssetImage('assets/ic_profile.png'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => homeController.fetchBooks(),
        child: ListView(
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                String username = user.value.username;
                return Text(
                  'Welcome Back, $username!',
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
            ),
            const Gap(20),
            buildCarousel(),
            const Gap(20),
            DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar(
                    onTap: (value) {
                      homeController.category = categories[value];
                    },
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
                  const Gap(20),
                  buildGridViewBooks(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridViewBooks() {
    return Obx(() {
      FetchState state = homeController.status.state;
      if (state == FetchState.init) {
        return DView.nothing();
      }
      if (state == FetchState.loading) {
        return DView.loadingCircle();
      }
      if (state == FetchState.failed) {
        return Column(
          children: [
            DButtonCircle(
              diameter: 40,
              onClick: () => homeController.fetchBooks(),
              child: const Icon(Icons.refresh),
            ),
            const Gap(16),
            DView.error(data: homeController.status.message),
          ],
        );
      }
      List<Book> booksBackup = homeController.books;
      String category = homeController.category;
      List<Book> books = category == 'All'
          ? List.from(booksBackup)
          : booksBackup.where((e) => e.genre == category).toList();
      if (books.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bg_books.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            const Gap(16),
            Text('Books with category $category still empty'),
          ],
        );
      }
      return GridView.builder(
        itemCount: books.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          Book book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailBookPage.route,
                arguments: book,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ExtendedImage.network(
                      book.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
    });
  }

  Column buildCarousel() {
    List list = [
      {
        'title': 'Fast Women',
        'author': 'Jennifer Cruise',
        'rating': 4.0,
        'image': 'assets/carousel_1.png',
      },
      {
        'title': 'the Patient',
        'author': 'Michael Palmer',
        'rating': 3.0,
        'image': 'assets/carousel_2.png',
      },
      {
        'title': 'Scared Ground',
        'author': 'Mercedes Lackey',
        'rating': 5.0,
        'image': 'assets/carousel_3.png',
      },
    ];
    return Column(
      children: [
        SizedBox(
          height: 145,
          child: PageView.builder(
            controller: pageController,
            itemCount: list.length,
            itemBuilder: (context, index) {
              Map item = list[index];
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
                              item['title'],
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['author'],
                            ),
                            const Gap(8),
                            RatingBar.builder(
                              initialRating: item['rating'],
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
                        item['image'],
                        height: 145,
                        fit: BoxFit.fitHeight,
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
