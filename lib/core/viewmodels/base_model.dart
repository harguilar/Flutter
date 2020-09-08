import 'package:gerente_loja/core/datamodels/user_model.dart';
import 'package:gerente_loja/core/services/authentication_service.dart';
import 'package:gerente_loja/locator.dart';
//import 'package:pistom/app/locator.dart';
//import 'package:pistom/core/datamodels/user_model.dart';
//import 'package:pistom/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  UserModel get currentUser => _authenticationService.currentUser;

}