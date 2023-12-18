import 'package:d_session/d_session.dart';
import 'package:get/get.dart';

class RecentSearchesController extends GetxController {
  final _recentSearchesKey = 'recent_searches';

  final _list = <String>[].obs;
  List<String> get list => _list;

  addNewQuery(String query) {
    List<String> newList = list..insert(0, query);
    if (newList.length > 5) newList.removeLast();

    DSession.setCustom(_recentSearchesKey, newList).then((saved) {
      if (saved) getList();
    });
  }

  getList() async {
    List? recents = await DSession.getCustom(_recentSearchesKey) as List?;
    _list.assignAll(List.from(recents ?? []));
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }
}
