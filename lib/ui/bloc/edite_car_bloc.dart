// ignore_for_file: non_constant_identifier_names

import 'package:imechano/ui/modal/edit_var_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class editecarbloc {
  final _editecarmodal = PublishSubject<Editecarliatmodel>();
  final _repository = Repository();

  Stream<Editecarliatmodel> get careditestream => _editecarmodal.stream;

  Future editecarsink(
      String user_id,
      String model,
      String cylinder,
      String mileage,
      String model_year,
      String plate_number,
      String chases_number,
      String id) async {
    final Editecarliatmodel editcarmodel = await _repository.editemodelAPI(
        user_id,
        model,
        cylinder,
        mileage,
        model_year,
        plate_number,
        chases_number,
        id);
    _editecarmodal.sink.add(editcarmodel);
  }

  void dispose() {
    _editecarmodal.close();
  }
}

final Editecarbloc = editecarbloc();
