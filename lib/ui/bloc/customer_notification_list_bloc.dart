import 'package:imechano/ui/modal/customer_notification_list_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CustomerNotificationListBloc {
  // ignore: non_constant_identifier_names
  final NotificationList = PublishSubject<CustomerNotificationListModel>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<CustomerNotificationListModel> get notificationListStream =>
      NotificationList.stream;

  // ignore: non_constant_identifier_names
  Future notificationListSinck(dynamic customer_id) async {
    final CustomerNotificationListModel? model =
        await _repository.oncustomerNotificationListApi(customer_id);
    if (model != null) NotificationList.sink.add(model);
  }

  void dispose() {
    NotificationList.close();
  }
}

final customerNotificationListBloc = CustomerNotificationListBloc();
