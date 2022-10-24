// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../views/forogot_password/forgot_password_route.dart';
import '../views/login/login_route.dart';
import '../views/main/main_route.dart';
import '../views/onboarding/onboarding_route.dart';
import '../views/register/register_route.dart';
import '../views/splash/splash_route.dart';
import '../views/store_details/store_details.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String logingRoute = "/login";
  static const String registergRoute = "/register";
  static const String forgotPasswordgRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/stroreDetails";
  static const String onBoardingRoute = "/onBoarding";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logingRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registergRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.forgotPasswordgRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(StringManager.noRountFound),
              ),
              body: const Text(StringManager.noRountFound),
            ));
  }
}
