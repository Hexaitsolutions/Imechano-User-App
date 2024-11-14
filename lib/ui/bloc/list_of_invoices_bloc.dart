import 'package:imechano/ui/modal/invoice_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class ListOfInvoicesBloc {
  final _listofinvoices = PublishSubject<InvoiceModel>();
  final _repository = Repository();

  Stream<InvoiceModel> get listofinvoicesstream => _listofinvoices.stream;

  // ignore: non_constant_identifier_names
  Future listofinvoicessink(String customer_id, String status, String startDate,
      String endDate) async {
    final InvoiceModel? listOfInvoicesModel = await _repository
        .onListOfInvoicesApi(customer_id, status, startDate, endDate);
    if (listOfInvoicesModel != null)
      _listofinvoices.sink.add(listOfInvoicesModel);
  }

  void dispose() {
    _listofinvoices.close();
  }
}

final listOfInvoicesBloc = ListOfInvoicesBloc();
