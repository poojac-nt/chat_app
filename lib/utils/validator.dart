class Validator {
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 8) {
      return 'Password should be more than 8 characters';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? email) {
    //TODO: Improve RegExp
    final regEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    } else if (!regEx.hasMatch(email.trim())) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }
}
