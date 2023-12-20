import 'package:booksforall/common/app_notif.dart';
import 'package:booksforall/common/enum.dart';
import 'package:booksforall/controllers/qna_controller.dart';
import 'package:booksforall/models/answer.dart';
import 'package:booksforall/models/qna.dart';
import 'package:d_button/d_button.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  final qnaController = Get.put(QnaController());

  @override
  void initState() {
    qnaController.fetchQnA();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          'QnA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        FetchState state = qnaController.status.state;
        if (state == FetchState.init) {
          return DView.nothing();
        }
        if (state == FetchState.loading) {
          return DView.loadingCircle();
        }
        if (state == FetchState.failed) {
          return DView.error(data: qnaController.status.message);
        }
        List<QnA> list = qnaController.list;
        if (list.isEmpty) {
          return const SizedBox(
            width: double.infinity,
            child: Column(
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
                Text('There is no QnA'),
              ],
            ),
          );
        }
        return ListView.separated(
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[300],
            );
          },
          itemBuilder: (context, index) {
            QnA qna = list[index];
            return Column(
              children: [
                Text(
                  qna.question.bookTitle,
                  // 'book title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          qna.question.question,
                          // 'question',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Gap(4),
                      DButtonFlat(
                        onClick: () {
                          buildInputAnswer(qna.question.id);
                        },
                        radius: 30,
                        height: 33,
                        width: 77,
                        mainColor: Theme.of(context).primaryColor,
                        child: const Text(
                          'Answer',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: Colors.grey[300],
                ),
                ListView.builder(
                  itemCount: qna.answerList.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Answer answer = qna.answerList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            answer.username,
                            // 'name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            answer.answer,
                            // 'answer nya',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xffA6A6A6),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }),
    );
  }

  buildInputAnswer(int questionId) {
    final edtAnswer = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DInput(
                controller: edtAnswer,
                fillColor: Colors.white,
                hint: 'type question here...',
                radius: BorderRadius.circular(10),
                minLine: 1,
                maxLine: 2,
              ),
              const Gap(20),
              DButtonFlat(
                onClick: () {
                  if (edtAnswer.text == '') {
                    return AppNotif.toastInvalid(
                      context,
                      'Answer must be filled',
                    );
                  }
                  Navigator.pop(context);
                  qnaController.answer(
                    questionId,
                    edtAnswer.text,
                    context,
                  );
                },
                radius: 30,
                height: 33,
                width: 128,
                mainColor: Theme.of(context).primaryColor,
                child: const Text(
                  'Answer',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }
}