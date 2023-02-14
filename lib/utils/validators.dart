class Validators {
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
}
