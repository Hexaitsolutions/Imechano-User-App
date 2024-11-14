import 'package:imechano/ui/modal/invoice_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class BookingInvoicesBloc {
  final _bookingInvoice = PublishSubject<InvoiceModel>();
  final _repository = Repository();

  Stream<InvoiceModel> get bookinginvoicestream => _bookingInvoice.stream;

  // ignore: non_constant_identifier_names
  Future bookinginvoicesink(
      String customer_id, String startDate, String endDate) async {
    final InvoiceModel? bookingInvoiceModel = await _repository
        .onListOfBookingInvoicesApi(customer_id, startDate, endDate);
    if (bookingInvoiceModel != null)
      _bookingInvoice.sink.add(bookingInvoiceModel);
  }

  void dispose() {
    _bookingInvoice.close();
  }
}

final bookingInvoicesBloc = BookingInvoicesBloc();
