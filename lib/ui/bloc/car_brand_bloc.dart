import 'package:imechano/ui/modal/car_brand_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CarBrandBloc {
  final _carbrandList = PublishSubject<CarBrandModel>();
  final _repositiry = Repository();

  Stream<CarBrandModel> get carbrandListStream => _carbrandList.stream;

  Future carbrandblocSink() async {
    final CarBrandModel model = await _repositiry.oncarbrandListAPI();
    _carbrandList.sink.add(model);
  }

  void dispose() {
    _carbrandList.close();
  }
}

final carbrandBloc = CarBrandBloc();
