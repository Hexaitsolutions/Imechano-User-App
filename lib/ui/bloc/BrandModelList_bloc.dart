import 'package:imechano/ui/modal/Brand_Model_list_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

// ignore: camel_case_types
class brandmoellistbloc {
  final _brandmodel = PublishSubject<BrandModelList>();
  final _repository = Repository();

  Stream<BrandModelList> get brandmodelstream => _brandmodel.stream;

  // ignore: non_constant_identifier_names
  Future brandmodellidtsink(String brand_id) async {
    final BrandModelList editcarmodel =
        await _repository.brandmodelisAPI(brand_id);
    _brandmodel.sink.add(editcarmodel);
  }

  void dispose() {
    _brandmodel.close();
  }
}

final branmodelbloc = brandmoellistbloc();
