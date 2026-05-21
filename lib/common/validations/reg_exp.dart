


String? validateLink(String? value) {
  if (value == null || value.trim().isEmpty) return null; 

  final urlPattern = r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-./?%&=]*)?$';
  final isValid = RegExp(urlPattern).hasMatch(value.trim());

  return isValid ? null : 'Enter a valid URL';
}


bool phoneNoValid(String phoneNo) {
  return RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$')
      .hasMatch(phoneNo);
}


bool checkEmailValidation(String email) {
  return RegExp(
    r"^[a-z0-9.!#\$%&'*+\-/=?^_`{|}~]+@[a-z0-9.-]+\.[a-z]+$",
    caseSensitive: false,
  ).hasMatch(email);
}


bool checkPostalCode(String code) {
  return RegExp(
    r'^(GIR ?0AA|(?:(?:[A-PR-UWYZ][0-9]{1,2}|[A-PR-UWYZ][A-HK-Y][0-9]{1,2}|[A-PR-UWYZ][0-9][A-HJKPSTUW]|[A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]) ?[0-9][ABD-HJLNP-UW-Z]{2}))$',
    caseSensitive: false,
  ).hasMatch(code);
}


bool isValidAustralianPhoneNumber(String phone) {
  final pattern = RegExp(r'^(\+61|0)[23478]\d{8}$');
  return pattern.hasMatch(phone) && phone.length == 10;
}

bool isValidPhoneNumber(String phone) {
  return RegExp(r'^[0-9]{10}$').hasMatch(phone);
}

bool isValidContactPhoneNumber(String phone) {
  return RegExp(r'^[0-9]{9}$').hasMatch(phone);
}

bool isValidBusinessPhoneNumber(String phone) {
  return RegExp(r'^[0-9]{10}$').hasMatch(phone);
}

bool isValidateABNNumber(String abn) {
  return RegExp(r'^\d{9,11}$').hasMatch(abn);
}

bool validateAusMobileNumber(String phone) {
  return RegExp(r'^4[0-9]{8}$').hasMatch(phone);
}
