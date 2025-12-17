import 'package:flutter/material.dart';

import '../../presentation/blocs/auth/auth_state.dart';

class AuthRouterRefresh extends ChangeNotifier {
  AuthRouterRefresh(Stream<AuthState> stream) {
    stream.listen((_) => notifyListeners());
  }
}
