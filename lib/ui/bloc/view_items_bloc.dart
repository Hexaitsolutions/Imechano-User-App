
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../modal/view_items_model.dart';

class ViewItemsDataBloc {
  final viewItemsdata = PublishSubject<ViewItemsModel>();
  final _repositiry = Repository();

  Stream<ViewItemsModel> get ViewItemsStream => viewItemsdata.stream;

  Future onViewItemsDataSink(String jobNumber) async {
    final ViewItemsModel model = await _repositiry.onViewItemsAPI(jobNumber);
    print("Data is loadead");
    print(model);
    viewItemsdata.sink.add(model);
  }

  void dispose() {
    viewItemsdata.close();
  }
}

final viewItemsDataBloc = ViewItemsDataBloc();
