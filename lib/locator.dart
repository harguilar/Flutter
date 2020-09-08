import 'package:gerente_loja/core/datamodels/proforma_data.dart';
import 'package:gerente_loja/core/services/api.dart';
import 'package:gerente_loja/core/services/authentication_service.dart';
import 'package:gerente_loja/core/services/cloud_storage_services.dart';
import 'package:gerente_loja/core/services/proforma_services.dart';
import 'package:gerente_loja/core/services/sellectedVehicleDetails.dart';
import 'package:gerente_loja/core/services/firestore_service.dart';
import 'package:gerente_loja/core/services/push_notifications.dart';
import 'package:gerente_loja/core/viewmodels/cloud_storage_result.dart';
import 'package:gerente_loja/core/viewmodels/proformaViewModel.dart';
import 'package:gerente_loja/core/viewmodels/startup_viewmodel.dart';
import 'package:gerente_loja/core/viewmodels/vehicleViewModel.dart';
import 'package:gerente_loja/utils/image_selector.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => Api('vehicle'));
  locator.registerLazySingleton(() => SellectedVehicleDetails());
  locator.registerLazySingleton(() => SnackbarService() );
  locator.registerLazySingleton(() => VehicleViewModel());
  locator.registerLazySingleton(() => ProformaViewModel());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => StartupViewModel());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => ProformaServices());
  locator.registerLazySingleton(() => ProformaData());
  locator.registerLazySingleton(() => CloudStorageService());
  //locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => CloudStorageResult());
  //locator.registerLazySingleton(() => PushNotificationService());
}
