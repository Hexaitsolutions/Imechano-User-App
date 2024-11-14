
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../modal/cust_joblist_model.dart';

// ignore: camel_case_types
class JobCardsListbloc {
  final _jobcardslist = PublishSubject<CustomerJobListModel>();
  final _repository = Repository();

  Stream<CustomerJobListModel> get jobcardsliststream => _jobcardslist.stream;

  // ignore: non_constant_identifier_names
  Future jobcardslistsink(String customer_id, String status, {String search="", String start_date = "0", String end_date="", String category=""}) async {
    final CustomerJobListModel jobcardsListModel =
        await _repository.JobCardsListAPI(customer_id, status, search, start_date, end_date, category);
    _jobcardslist.sink.add(jobcardsListModel);
  }

  void dispose() {
    _jobcardslist.close();
  }
}

final jobcardsListbloc = JobCardsListbloc();
