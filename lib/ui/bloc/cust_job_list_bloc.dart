import 'package:imechano/ui/modal/cust_joblist_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CustJobListAPIBloc {
  final _CustomerJobList = PublishSubject<CustomerJobListModel>();
  final _repositiry = Repository();

  Stream<CustomerJobListModel> get CustomerJobListStream =>
      _CustomerJobList.stream;

  Future oncustomerjobblocSink(String jobNumber) async {
    final CustomerJobListModel model =
        await _repositiry.onCustJobListAPI(jobNumber);
    _CustomerJobList.sink.add(model);
  }

  void dispose() {
    _CustomerJobList.close();
  }
}

final custJobListAPIBloc = CustJobListAPIBloc();
