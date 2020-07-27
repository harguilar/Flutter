import 'package:gerente_loja/core/models/crudModel.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => Api('vehicles'));
  locator.registerLazySingleton(() => CRUDModel());
}
