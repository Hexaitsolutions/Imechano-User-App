// ignore_for_file: non_constant_identifier_names

import 'package:imechano/ui/modal/view_services_model.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class ViewServicesDataBloc {
  final viewservicesdata = PublishSubject<ViewServiceModel>();
  final _repositiry = Repository();

  Stream<ViewServiceModel> get ViewServicesStream => viewservicesdata.stream;

  Future onViewServicesDataSink(String job_number) async {
    final ViewServiceModel model =
        await _repositiry.onViewServicesAPI(job_number);
    viewservicesdata.sink.add(model);
  }

  void dispose() {
    viewservicesdata.close();
  }
}

final viewServicesDataBloc = ViewServicesDataBloc();
