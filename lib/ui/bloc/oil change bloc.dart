// ignore_for_file: non_constant_identifier_names

import 'package:imechano/ui/modal/oilchange_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class OilchangeListBloc {
  final oilchnage = PublishSubject<OilChangeModel>();
  final _repository = Repository();

  Stream<OilChangeModel> get OilchnageListStream => oilchnage.stream;

  Future oilChnageSinck(
    String category_id,
  ) async {
    print("Catogory ID ");
    print(category_id);

    final OilChangeModel? model = await _repository.onOilChange(category_id);
    oilchnage.sink.add(model!);
  }

  void dispose() {
    oilchnage.close();
  }
}

final oilchnageListBloc = OilchangeListBloc();
