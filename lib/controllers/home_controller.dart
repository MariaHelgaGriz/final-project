import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/book.dart';
import 'package:booksforall/models/fetch_status_model.dart';
import 'package:booksforall/source/book_source.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _status = FetchStatusModel.init.obs;
  FetchStatusModel get status => _status.value;
  set status(FetchStatusModel n) => _status.value = n;

  final _category = 'All'.obs;
  String get category => _category.value;
  set category(String n) => _category.value = n;

  final _books = <Book>[].obs;
  List<Book> get books => _books;

  fetchBooks() async {
    status = FetchStatusModel(FetchState.loading);
    final result = await BookSource.all();
    result.fold(
      (message) {
        status = FetchStatusModel(FetchState.failed, message);
      },
      (data) {
        status = FetchStatusModel(FetchState.success);
        _books.value = data;
      },
    );
  }
}
