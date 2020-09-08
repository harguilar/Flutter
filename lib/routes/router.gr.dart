// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/brands_screen.dart';
import '../ui/views/loginPage.dart';
import '../ui/views/login_view.dart';
import '../ui/views/otp_view.dart';
import '../ui/views/proforma_screen.dart';
import '../ui/views/signup_view.dart';
import '../ui/views/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String brandsScreens = '/brands-screens';
  static const String proformaScreen = '/proforma-screen';
  static const String loginPageScreen = '/login-page-screen';
  static const String signUpView = '/sign-up-view';
  static const String otpView = '/otp-view';
  static const String loginView = '/login-view';
  static const all = <String>{
    startupView,
    brandsScreens,
    proformaScreen,
    loginPageScreen,
    signUpView,
    otpView,
    loginView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.brandsScreens, page: brandsScreens),
    RouteDef(Routes.proformaScreen, page: ProformaScreen),
    RouteDef(Routes.loginPageScreen, page: LoginPageScreen),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.otpView, page: OtpView),
    RouteDef(Routes.loginView, page: LoginView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    brandsScreens: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => brandsScreens(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    ProformaScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProformaScreen(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    LoginPageScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPageScreen(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    SignUpView: (data) {
      final args = data.getArgs<SignUpViewArguments>(
        orElse: () => SignUpViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpView(phone: args.phone),
        settings: data,
        fullscreenDialog: true,
      );
    },
    OtpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OtpView(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
        fullscreenDialog: true,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SignUpView arguments holder class
class SignUpViewArguments {
  final String phone;
  SignUpViewArguments({this.phone});
}
