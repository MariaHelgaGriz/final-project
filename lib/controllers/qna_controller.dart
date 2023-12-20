import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/models/fetch_status_model.dart';
import 'package:booksforall/models/qna.dart';
import 'package:booksforall/source/qna_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QnaController extends GetxController {
  final _status = FetchStatusModel.init.obs;
  FetchStatusModel get status => _status.value;
  set status(FetchStatusModel n) => _status.value = n;

  final _list = <QnA>[].obs;
  List<QnA> get list => _list;

  fetchQnA() async {
    status = FetchStatusModel(FetchState.loading);
    final result = await QnaSource.all();
    result.fold(
      (message) {
        status = FetchStatusModel(FetchState.failed, message);
      },
      (data) {
        status = FetchStatusModel(FetchState.success);
        _list.value = data;
      },
    );
  }

  answer(int questionId, String answer, BuildContext context) async {
    final result = await QnaSource.addAnswer(questionId, answer);
    result.fold(
      (messageFailed) => AppNotif.failed(context, messageFailed),
      (messageSuccess) {
        fetchQnA();
        AppNotif.success(context, messageSuccess);
      },
    );
  }
}