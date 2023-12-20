import 'package:booksforall/common/enum.dart';

class FetchStatusModel {
  final FetchState state;
  final String message;

  FetchStatusModel(this.state, [this.message = '']);

  static FetchStatusModel get init => FetchStatusModel(FetchState.init);
}
