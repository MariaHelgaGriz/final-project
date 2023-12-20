import 'package:booksforall/controllers/recent_searches_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const route = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final recentSearchesController = Get.put(RecentSearchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE8E8E8),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(
                    AssetImage('assets/ic_search.png'),
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      recentSearchesController.addNewQuery(value);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildSearchResult(),
          buildRecentSearches(),
        ],
      ),
    );
  }

  Widget buildSearchResult() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Gap(16),
      ],
    );
  }

  Widget buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Gap(16),
        Obx(
          () {
            List<String> list = recentSearchesController.list;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff8B8B97),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}