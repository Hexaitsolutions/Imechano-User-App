import 'package:imechano/ui/modal/categoriesModelClass.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CategoriesListBloc {
  // ignore: non_constant_identifier_names
  final _Category = PublishSubject<CategoriesModelClass>();
  final _repository = Repository();

  // ignore: non_constant_identifier_names
  Stream<CategoriesModelClass> get CategoryListStream => _Category.stream;

  // ignore: non_constant_identifier_names
  Future categoriesSinck(dynamic brand_id) async {
    print("123123123");

    final CategoriesModelClass? model =
        await _repository.onCategories(brand_id);
    print('Brand ID ');
    print(brand_id);
    if(model != null)
    _Category.sink.add(model);
  }

  void dispose() {
    _Category.close();
  }
}

final categoriesListBloc = CategoriesListBloc();
