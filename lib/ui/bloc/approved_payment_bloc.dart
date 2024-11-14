import 'package:imechano/ui/modal/Approvedcharged_model.dart';

import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ApprovedpaymentsendnotificationBloc {
  // ignore: non_constant_identifier_names
  final sendnotificationdminList =
      PublishSubject<ApprovedchargesbycustomerModel>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<ApprovedchargesbycustomerModel> get SendnotificationListStream =>
      sendnotificationdminList.stream;

  // ignore: non_constant_identifier_names
  Future sendnotificationListSinck(String booking_id) async {
    final ApprovedchargesbycustomerModel? model =
        await _repository.oncustomerApprovedApi(booking_id);
    sendnotificationdminList.sink.add(model!);
  }

  void dispose() {
    sendnotificationdminList.close();
  }
}

final approvedpaymentsendnotificationBloc =
    ApprovedpaymentsendnotificationBloc();
