class Validator {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is Required';
    } else if (!RegExp(r'^01[0125][0-9]$').hasMatch(value)) {
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
}
