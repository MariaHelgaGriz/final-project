import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/fetch_status_model.dart';
import 'package:booksforall/models/review.dart';
import 'package:booksforall/source/cart_source.dart';
import 'package:booksforall/source/qna_source.dart';
import 'package:booksforall/source/review_source.dart';
import 'package:booksforall/source/wishlist_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final _isWishlist = false.obs;
  bool get isWishlist => _isWishlist.value;
  set isWishlist(bool n) => _isWishlist.value = n;

  final _status = FetchStatusModel.init.obs;
  FetchStatusModel get status => _status.value;
  set status(FetchStatusModel n) => _status.value = n;

  final _reviews = <Review>[].obs;
  List<Review> get reviews => _reviews;

  fetchReviews(int bookId) async {
    status = FetchStatusModel(FetchState.loading);
    final result = await ReviewSource.all(bookId);
    result.fold(
      (message) {
        status = FetchStatusModel(FetchState.failed, message);
      },
      (data) {
        status = FetchStatusModel(FetchState.success);
        _reviews.value = data;
      },
    );
  }

  addToCart(int bookId, BuildContext context) async {
    final result = await CartSource.add(bookId);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) => AppNotif.success(context, messageSuccess),
    );
  }

  addReview(int bookId, String review, BuildContext context) async {
    final result = await ReviewSource.add(bookId, review);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) {
        fetchReviews(bookId);
        AppNotif.success(context, messageSuccess);
      },
    );
  }

  ask(int bookId, String question, BuildContext context) async {
    final result = await QnaSource.addQuestion(bookId, question);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) => AppNotif.success(context, messageSuccess),
    );
  }

  checkWishlist(int bookId) async {
    final result = await WishlistSource.check(bookId);
    result.fold(
      (messageFailed) {},
      (isAdded) => isWishlist = isAdded,
    );
  }

  addDeleteWishlist(int bookId, BuildContext context) async {
    if (isWishlist) {
      final result = await WishlistSource.delete(bookId);
      result.fold(
        (messageFailed) => AppNotif.failed(context, messageFailed),
        (messageSuccess) {
          isWishlist = false;
          AppNotif.success(context, messageSuccess);
        },
      );
    } else {
      final result = await WishlistSource.add(bookId);
      result.fold(
        (messageFailed) => AppNotif.failed(context, messageFailed),
        (messageSuccess) {
          isWishlist = true;
          AppNotif.success(context, messageSuccess);
        },
      );
    }
  }
}
