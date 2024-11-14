
import 'package:imechano/ui/modal/delete_car_model.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DeleteCarBloc {
  // ignore: non_constant_identifier_names
  final DeleteCar = PublishSubject<DeleteCarModel>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<DeleteCarModel> get deleteCarStream => DeleteCar.stream;

  // ignore: non_constant_identifier_names
  Future deleteCarSinck(String id) async {
    print("123123123");

    final DeleteCarModel? model = await _repository.DeleteCarAPI(id);
    DeleteCar.sink.add(model!);
  }

  void dispose() {
    DeleteCar.close();
  }
}

final deleteCarBloc = DeleteCarBloc();
