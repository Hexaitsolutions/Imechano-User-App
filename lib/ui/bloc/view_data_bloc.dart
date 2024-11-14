import 'package:imechano/ui/modal/view_parts_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ViewPartsDataBloc {
  final viewpartsdata = PublishSubject<ViewPartsModel>();
  final _repositiry = Repository();

  Stream<ViewPartsModel> get ViewpartsStream => viewpartsdata.stream;

  Future onViewPartsDataSink(String jobNumber) async {
    final ViewPartsModel model = await _repositiry.onViewDataAPI(jobNumber);
    viewpartsdata.sink.add(model);
  }

  void dispose() {
    viewpartsdata.close();
  }
}

final viewPartsDataBloc = ViewPartsDataBloc();
