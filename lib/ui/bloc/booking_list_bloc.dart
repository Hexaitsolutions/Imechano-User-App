import 'dart:developer';

import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class BookingListbloc {
  final _bookinglist = PublishSubject<BookingListModel>();
  final _repository = Repository();

  Stream<BookingListModel> get bookingliststream => _bookinglist.stream;

  // ignore: non_constant_identifier_names
  Future bookinglistsink(String customer_id, String status,
      {String search = "",
      String start_date = "0",
      String end_date = "",
      String category = ""}) async {
    log('Inside booking list sink: $customer_id, $status');
    log('Inside booking list sink with new status: $customer_id, $status');
    final BookingListModel? bookingListModel = await _repository.BookingListAPI(
        customer_id, status, search, start_date, end_date, category);
    if (bookingListModel != null) _bookinglist.sink.add(bookingListModel);
  }

  void dispose() {
    _bookinglist.close();
  }
}

final bookingListbloc = BookingListbloc();
