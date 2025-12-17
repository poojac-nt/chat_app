class CustomFirebaseExceptions {
  static String customExceptionMessage(String exception) {
    String message;
    switch (exception) {
      case 'user-not-found':
        message = 'No account found with this email';
        break;
      case 'wrong-password':
        message = 'Incorrect password';
        break;
      case 'email-already-in-use':
        message = 'An account already exists with this email';
        break;
      default:
        message = 'Authentication failed. Please try again';
    }
    return message;
  }
}
