import 'package:chat_app/core/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/auth/auth_state.dart';
import '../../utils/app_constants.dart';
import 'auth_router_refresh.dart';

class AppRouter {
  static late final GoRouter _router;

  static void init(AuthBloc authBloc) {
    _router = GoRouter(
      routes: routes,
      initialLocation: AppRoutes.splashScreen,
      debugLogDiagnostics: !kReleaseMode,
      refreshListenable: AuthRouterRefresh(authBloc.stream),

      redirect: (context, state) {
        final authState = authBloc.state;
        final location = state.matchedLocation;

        debugPrint(
          "AppRouter Redirect: Current Location: $location, AuthState: $authState",
        );

        // If currently on Splash Screen:
        if (location == AppRoutes.splashScreen) {
          // Stay on splash screen if we are still Initializing (AuthInitial or Loading)
          if (authState is AuthInitial || authState is AuthLoading) {
            return null; // Stay here
          }
          // If state changed to Unauthenticated -> Go to Login
          if (authState is UnAuthenticated) {
            return AppRoutes.signInScreen;
          }
          // If state changed to Success -> Go to Profile
          if (authState is Authenticated) {
            return AppRoutes.chatListScreen;
          }
        }

        final isLoggingIn = location == AppRoutes.signInScreen;
        final isSigningUp = location == AppRoutes.signUpScreen;
        final isResettingPassword = location == AppRoutes.resetPasswordScreen;
        final isPublicPage = isLoggingIn || isSigningUp || isResettingPassword;

        // Guard: If Unauthenticated and trying to access private page -> Login
        if (authState is UnAuthenticated && !isPublicPage) {
          return AppRoutes.signInScreen;
        }

        // Guard: If Authenticated and trying to access public page -> Profile
        if (authState is Authenticated && isPublicPage) {
          return AppRoutes.profileScreen;
        }

        return null;
      },
    );
  }

  static GoRouter get router => _router;
}
