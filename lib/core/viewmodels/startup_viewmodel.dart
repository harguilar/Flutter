import 'package:flutter/cupertino.dart';
import 'package:gerente_loja/core/services/push_notifications.dart';
import 'package:gerente_loja/locator.dart';
//import 'package:pistom/constants/route_names.dart';
import 'package:gerente_loja/core/services/authentication_service.dart';

//import 'package:pistom/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends  BaseViewModel{

  final AuthenticationService _authenticationService= locator<AuthenticationService>();
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();
  //final NavigationService _navigationService=locator<NavigationService>();

  Future handleStartUpLogic(VoidCallback navToHome,VoidCallback navToLogin) async{
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    await _pushNotificationService.initialise();

    if(hasLoggedInUser){

      return _authenticationService.currentUser;
      navToHome();
      return _authenticationService.currentUser;
    }else{
      return _authenticationService.signIn(phone: null, smsCode: null, onSuccess: null, onFailed: null, verificationId: null);

    }
  }
}