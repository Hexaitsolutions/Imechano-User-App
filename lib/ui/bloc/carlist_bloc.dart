import 'package:imechano/ui/modal/carList_modelclass.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CarListListBloc {
  // ignore: non_constant_identifier_names
  final CarList = PublishSubject<CarListModelClass>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<CarListModelClass> get CarListStream => CarList.stream;

  // ignore: non_constant_identifier_names
  Future carListSinck(dynamic user_id) async {
    print("123123123");

    final CarListModelClass? model = await _repository.onaddCar(user_id);
    CarList.sink.add(model!);
  }

  void dispose() {
    CarList.close();
  }
}

final carListListBloc = CarListListBloc();
