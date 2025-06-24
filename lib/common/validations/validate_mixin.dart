import 'package:di360_flutter/common/validations/reg_exp.dart';

mixin ValidationMixins {
  String? validatePhoneNumber(value) {
    if (value!.isEmpty) {
      String errortext = "Please enter your Mobile Number";
      return errortext;
    } else if (!isValidAustralianPhoneNumber(value)) {
      String errortext = 'Enter vaild  mobile number';
      return errortext;
    }

    return null;
  }

  String? validateFirstName(value) {
    if (value!.isEmpty) {
      return "Please enter first name";
    }
    return null;
  }

  String? validatelastName(value) {
    if (value!.isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    return null;
  }

  String? validateName(value) {
    if (value!.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter your email";
    } else if (!checkEmailValidation(value)) {
      return 'Enter vaild email';
    }
    return null;
  }

  String? validateRegistration(value) {
    if (value!.isEmpty) {
      return "Please enter registration no";
    }
    return null;
  }

  String? validatename(value) {
    if (value!.isEmpty) {
      return "Please enter name";
    }
    return null;
  }

  String? validateNumber(value) {
    if (value!.isEmpty) {
      return "Please enter telephone number";
    }
    return null;
  }

  String? validateDesc(value) {
    if (value!.isEmpty) {
      return "Please enter description";
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  String? validateOptionalUrl(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);

    if (uri == null ||
        !(uri.isAbsolute &&
            (uri.hasScheme &&
                (uri.scheme == 'http' || uri.scheme == 'https')))) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  String? validateBusiness(value) {
    if (value!.isEmpty) {
      return "Please enter business name";
    }
    return null;
  }

  String? validateState(value) {
    if (value!.isEmpty) {
      return "Please enter state";
    }
    return null;
  }

  String? validatePostalCode(value) {
    if (value!.isEmpty) {
      return "Please enter postal code";
    }
    return null;
  }
}
