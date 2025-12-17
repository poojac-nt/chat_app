import 'package:go_router/go_router.dart';

import '../../presentation/screens/auth/sign_in_screen.dart';
import '../../presentation/screens/auth/sign_up_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../splash_screen.dart';
import '../../utils/app_constants.dart';

List<GoRoute> routes = [
  GoRoute(
    path: AppRoutes.profileScreen,
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: AppRoutes.signUpScreen,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: AppRoutes.signInScreen,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: AppRoutes.splashScreen,
    builder: (context, state) => const SplashScreen(),
  ),
];
