import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/book.dart';
import 'package:booksforall/models/fetch_status_model.dart';
import 'package:booksforall/source/cart_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _status = FetchStatusModel.init.obs;
  FetchStatusModel get status => _status.value;
  set status(FetchStatusModel n) => _status.value = n;

  final _books = <Book>[].obs;
  List<Book> get books => _books;

  fetchCarts() async {
    status = FetchStatusModel(FetchState.loading);
    final result = await CartSource.all();
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

  deleteItemCart(int bookId, BuildContext context) async {
    final result = await CartSource.delete(bookId);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) {
        fetchCarts();
        AppNotif.success(context, messageSuccess);
      },
    );
  }
}
