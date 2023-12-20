import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/fetch_status_model.dart';
import 'package:booksforall/models/wishlist.dart';
import 'package:booksforall/source/wishlist_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  final _status = FetchStatusModel.init.obs;
  FetchStatusModel get status => _status.value;
  set status(FetchStatusModel n) => _status.value = n;

  final _wishlists = <Wishlist>[].obs;
  List<Wishlist> get wishlists => _wishlists;

  fetchWishlist() async {
    status = FetchStatusModel(FetchState.loading);
    final result = await WishlistSource.all();
    result.fold(
      (message) {
        status = FetchStatusModel(FetchState.failed, message);
      },
      (data) {
        status = FetchStatusModel(FetchState.success);
        _wishlists.value = data;
      },
    );
  }

  deleteItemWishlist(int bookId, BuildContext context) async {
    final result = await WishlistSource.delete(bookId);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) {
        fetchWishlist();
        AppNotif.success(context, messageSuccess);
      },
    );
  }
}
