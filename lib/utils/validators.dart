class Validators {
  static String? isEmpty(String? name) {
    if (name == null || name.isEmpty) {
      return 'Field cannot be null';
    }
    return null;
  }

  static String? isEmailValid(String? email) {
    if (email == null) {
      return 'email cannot be empty';
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return null;
    } else {
      return 'Invalid email id';
    }
  }

  static String? isPasswordValid(String? password) {
    if (password == null || password.length < 6) {
      // TODO: Improve
      return 'min length is 6 letters';
    }
    return null;
  }
}
