// ignore_for_file: non_constant_identifier_names

import 'package:imechano/ui/modal/select-car-details_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class CarDetailsBloc {
  final _selectedCardDetail = PublishSubject<CarDetailsModel>();
  final _repository = Repository();

  Stream<CarDetailsModel> get carDetailsstream => _selectedCardDetail.stream;

  Future carDetailssink(String car_id) async {
    final CarDetailsModel selectedCardDetail =
        await _repository.onSelCarDetailsApi(car_id);
    _selectedCardDetail.sink.add(selectedCardDetail);
  }

  void dispose() {
    _selectedCardDetail.close();
  }
}

final carDetailsBloc = CarDetailsBloc();
