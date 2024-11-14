import 'package:imechano/ui/modal/car_booking_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class CarBookingbloc {
  final _carbooking = PublishSubject<CarBookingModal>();
  final _repository = Repository();

  Stream<CarBookingModal> get carbookingstream => _carbooking.stream;

  // ignore: non_constant_identifier_names
  Future carbookingsink(
      String customerid,
      String categoryid,
      String subcategoryid,
      String itemid,
      String timedate,
      String address,
      String total,
      String carid) async {
    final CarBookingModal carbookingmodel = await _repository.carbookingAPI(
        customerid,
        categoryid,
        subcategoryid,
        itemid,
        timedate,
        address,
        total,
        carid);
    _carbooking.sink.add(carbookingmodel);
  }

  void dispose() {
    _carbooking.close();
  }
}

final carbookingbloc = CarBookingbloc();
