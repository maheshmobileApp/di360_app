import 'package:di360_flutter/common/validations/reg_exp.dart';

mixin ValidationMixins {
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return "Please enter your Mobile Number";
    if (!isValidAustralianPhoneNumber(value)) return 'Enter valid mobile number';
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) return "Please enter first name";
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) return "Please enter last name";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Please enter password";
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your name";
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    if (!checkEmailValidation(value)) return 'Enter valid email';
    return null;
  }

  String? validateRegistration(String? value) {
    if (value == null || value.isEmpty) return "Please enter registration no";
    return null;
  }

  String? validateBusiness(String? value) {
    if (value == null || value.isEmpty) return "Please enter business name";
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.isEmpty) return "Please enter state";
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) return "Please enter postal code";
   // if (!checkPostalCode(value)) return 'Enter valid postal code';
    return null;
  }

  String? validateDesc(String? value) {
    if (value == null || value.isEmpty) return "Please enter description";
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) return 'Please select a category';
    return null;
  }

  String? validateOptionalUrl(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !(uri.isAbsolute && uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'))) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  String? validateRequiredDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) return 'Please select $fieldName';
    return null;
  }

  String? validateSalaryField(String? value, {required String field}) {
    if (value == null || value.trim().isEmpty) return 'Please enter $field salary';
    if (double.tryParse(value.trim()) == null) return 'Please enter a valid number';
    return null;
  }

  String? validateStartDate(bool isEnabled, DateTime? startDate) {
    if (isEnabled && startDate == null) return 'Please select a start date';
    return null;
  }

  String? validateEndDate(bool isEnabled, DateTime? endDate) {
    if (isEnabled && endDate == null) return 'Please select an end date';
    return null;
  }
  String? validateServiceStartTimeDate(bool isEnabled, DateTime? ServiceStartTimeDate) {
    if (isEnabled && ServiceStartTimeDate == null)
     return 'Please select a  Service start time';
    return null;
  }

  String? validateServiceEndTimeDate(bool isEnabled, DateTime? ServiceEndTimeDate) {
    if (isEnabled && ServiceEndTimeDate == null) 
    return 'Please select an  Service end time';
    return null;
  }
  String? validateBreakStartTimeDate(bool isEnabled, DateTime? BreakStartTimeDate) {
    if (isEnabled && BreakStartTimeDate == null) 
    return 'Please select a Break start time';
    return null;
  }

  String?validateBreakEndTimeDate (bool isEnabled, DateTime? BreakEndTimeDate) {
    if (isEnabled && BreakEndTimeDate == null) 
    return 'Please select an Break end time';
    return null;
  }
  
  String? validateCatagoryName(String? value) {
    if (value == null || value.isEmpty) return 'Please select category name';
    return null;
  }
    
    String? validateBannerName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter banner name';
    return null;
  }
   String? validateUrl(String? value) {
    if (value == null || value.isEmpty) return 'Please enter URL';
    return null;
  }
}
