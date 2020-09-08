import 'package:auto_route/auto_route_annotations.dart';
import 'package:gerente_loja/ui/views/brands_screen.dart';
import 'package:gerente_loja/ui/views/loginPage.dart';
import 'package:gerente_loja/ui/views/login_view.dart';
import 'package:gerente_loja/ui/views/otp_view.dart';
import 'package:gerente_loja/ui/views/proforma_screen.dart';
import 'package:gerente_loja/ui/views/signup_view.dart';
import 'package:gerente_loja/ui/views/startup_view.dart';



@MaterialAutoRouter(
  routes: <AutoRoute> [
    MaterialRoute(page: brandsScreens, initial: true),
    //MaterialRoute(page: brandsScreens, fullscreenDialog: true),
    MaterialRoute(page: ProformaScreen, fullscreenDialog: true),
    MaterialRoute(page: LoginPageScreen, fullscreenDialog: true),
    MaterialRoute(page: SignUpView, fullscreenDialog: true),
    MaterialRoute(page: OtpView, fullscreenDialog: true),
    MaterialRoute(page: LoginView, fullscreenDialog: true),
   // MaterialRoute(page: SignUpScreen, fullscreenDialog: true),
  ],
)
class $Router {}