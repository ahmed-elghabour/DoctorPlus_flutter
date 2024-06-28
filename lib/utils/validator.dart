class Validator {
  static String? generalValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email => example@doctor.com';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? rePasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String firebaseRegisterValidator(String error) {
    if (error.contains("email-already-in-use")) {
      return 'The email address is already in use by another account.';
    } else if (error.contains("invalid-email")) {
      return 'The email address is not valid.';
    } else if (error.contains("operation-not-allowed")) {
      return 'Email/password accounts are not enabled.';
    } else if (error.contains("weak-password")) {
      return 'The password is too weak.';
    } else if (error.contains("user-disabled")) {
      return 'The user account has been disabled.';
    } else {
      return 'An unknown error occurred: $error';
    }
  }

  static String firebaseLoginValidator(String error) {
    if (error.contains("invalid-email")) {
      return 'The email address is not valid.';
    } else if (error.contains("user-disabled")) {
      return 'The user account has been disabled.';
    } else if (error.contains("user-not-found")) {
      return 'No user found with this email.';
    } else if (error.contains("wrong-password")) {
      return 'The password is incorrect.';
    } else if (error.contains("too-many-requests")) {
      return 'Too many unsuccessful login attempts. Please try again later.';
    } else if (error.contains("operation-not-allowed")) {
      return 'Email/password accounts are not enabled.';
    } else {
      return 'An unknown error occurred: $error';
    }
  }

  static String locationValidator(String error) {
    if (error.isEmpty) {
      return 'complaint body is required';
    }

    return "";
  }

  static String? complaintBodyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'complaint body is required';
    }

    return null;
  }

  static String feesValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (int.parse(value) <= 0) {
      return 'Fees must be greater than zero';
    } else {
      return "invalid fees";
    }
  }

  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (value.length < 20) {
      return 'Too short description';
    }
    return null;
  }
}
