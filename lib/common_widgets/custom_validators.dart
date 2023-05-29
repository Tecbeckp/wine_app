class CustomValidator {
  static String? email(String? value) {
    if (!RegExp(r"""
^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
        .hasMatch(value!)) {
      return 'Email is Invalid';
    }
    return null;
  }

  static String? isValidPassword(String? password) {
    if (password!.length < 6) {
      return 'Password should be greater then 6 digits';
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.length < 6) {
      return 'Password should be greater then 6 digits';
    }
    return null;
  }

  static String? confirmPassword(String? value, String oldPassword) {
    if (value != oldPassword) {
      return 'Confirm password is not same';
    }
    return null;
  }

  static String? isEmpty(String? value) {
    return (value!.isEmpty) ? 'Field could not be empty' : null;
  }

  static String? lessThen2(String? value) {
    return (value!.length < 2) ? 'Enter more then 1 characters' : null;
  }

  static String? lessThen3(String? value) {
    return (value!.length < 3) ? 'Enter more then 2 characters' : null;
  }

  static String? lessThen4(String? value) {
    return (value!.length < 4) ? 'Enter more then 3 characters' : null;
  }

  static String? lessThen5(String? value) {
    return (value!.length < 5) ? 'Enter more then 4 characters' : null;
  }

  static String? greaterThen(String? input, double compairWith) {
    return (double.parse(input ?? '0') < compairWith)
        ? 'New input must be greater'
        : null;
  }

  static String? returnNull(String? value) => null;

  static String? validateDOB(String? value) {
    // Use a regular expression to check if the input string is a valid date
    String pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value!)) {
      return 'Invalid date format (YYYY-DD-MM)';
    }
    print(value);
    // Use the parse method of the DateTime class to convert the string to a date
    DateTime date;
    try {
      date = DateTime.parse(value);
    } catch (e) {
      return 'Invalid date';
    }

    // Check if the month is greater than 12 or the day is greater than 31
    print("date.day");
    print(date);
    print(date.day);
    print(date.month);
    if (date.month > 12 || date.day > 31) {
      return 'Invalid date';
    }

    // Check if the date is in the future
    if (date.isAfter(DateTime.now())) {
      return 'Cannot enter a future date';
    }

    return null;
  }
}
