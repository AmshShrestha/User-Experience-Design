import 'package:travel_log/features/auth/presentation/view/profile_view.dart';
import 'package:travel_log/features/details/presentation/view/enter_details.dart';
import 'package:travel_log/features/home/presentation/view/dashboard_view.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/registration_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String detailRoute = '/detail';
  static const String logRoute = '/log';
  static const String itineraryRoute = '/itinerary';
  static const String profileRoute = '/profile';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegistrationView(),
      homeRoute: (context) => const DashboardView(),
      detailRoute: (context) => const EnterDetails(),
      profileRoute: (context) => const ProfileView(),
    };
  }
}
