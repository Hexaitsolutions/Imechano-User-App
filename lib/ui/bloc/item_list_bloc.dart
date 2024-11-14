// ignore_for_file: non_constant_identifier_names

import 'package:imechano/ui/modal/item_list_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ItemListBloc {
  final _itemList = PublishSubject<ItemListModel>();
  final _repository = Repository();

  Stream<ItemListModel> get ItemListStream => _itemList.stream;

  Future ItemlistSinck(String sub_category_id) async {
    print(sub_category_id);
    final ItemListModel? model = await _repository.onitemlist(sub_category_id);
    if(model != null)
    _itemList.sink.add(model);
  }

  void dispose() {
    _itemList.close();
  }
}

final itemlistBloc = ItemListBloc();
