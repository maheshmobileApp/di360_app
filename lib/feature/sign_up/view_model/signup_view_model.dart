import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/sign_up/model_class/get_business_type.dart';
import 'package:di360_flutter/feature/sign_up/model_class/signup_res.dart';
import 'package:di360_flutter/feature/sign_up/model_class/subscription_res.dart';
import 'package:di360_flutter/feature/sign_up/querys/signup_querys.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class SignupViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();

  List<SubscriptionPlans>? subscriptionPlanList;
  List<DirectoryBusinessTypes>? directoryBusinessTypes;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController conformController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController ahpraRegistrationNumber = TextEditingController();
  final TextEditingController abnNumber = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool _isconformPassVisible = false;
  bool get isConformPasswordVisible => _isconformPassVisible;

  void toggleConformPasswordVisibility() {
    _isconformPassVisible = !_isconformPassVisible;
    notifyListeners();
  }

  String _countryCode = '+61'; // default AU
  String _number = '';

  String get countryCode => _countryCode;
  String get number => _number;

  String get fullPhone => '$_countryCode$_number';

  // last 3 digits
  String get lastThree =>
      _number.length >= 3 ? _number.substring(_number.length - 3) : _number;

  void setCountry(String code) {
    _countryCode = code;
    notifyListeners();
  }

  List<String> phoneCodeList = ['AU (+61)', 'NZ (+64)'];
  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
  }

  void setNumber(String value) {
    _number = value;
    notifyListeners();
  }

  String? selectedSubscriptionType;
  String? selectedPlanId;
  String? selectedPlanName;
  Map<String, String>? selectedType;

  void setSelectedType(Map<String, String>? type) {
    selectedType = type;
    notifyListeners();
  }

  void setSelectedSubscriptionType(
      String? type, String? planId, String? planName) {
    selectedSubscriptionType = type;
    selectedPlanId = planId;
    selectedPlanName = planName;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    selectedCategorys = null;
    notifyListeners();
  }

  bool agreeToTerms = false;

  void setAgreeToTerms(bool value) {
    agreeToTerms = value;
    notifyListeners();
  }

  DirectoryCategories? selectedCategorys;
  DirectoryCategories? get selectedCategory => selectedCategorys;

  void selectCategory(DirectoryCategories category) {
    if (selectedCategorys?.id == category.id) {
      selectedCategorys = null;
    } else {
      selectedCategorys = category;
    }
    notifyListeners();
  }

  subscriptionPlans() async {
    try {
      final res = await _http.query(subscriptionQuery);
      if (res != null) {
        final data = SubscriptionData.fromJson(res);
        subscriptionPlanList = data.subscriptionPlans;
      }
    } catch (e) {
      scaffoldMessenger("Error removing like: $e");
    }
    notifyListeners();
  }

  businessType(BuildContext context) async {
    Loaders.circularShowLoader(context);
    _selectedIndex = 0;
    try {
      final res = await _http
          .query(businessQuery, variables: {"type": selectedType?['type']});
      if (res != null) {
        final data = BusinessData.fromJson(res);
        directoryBusinessTypes = data.directoryBusinessTypes;
        navigationService.navigateTo(RouteList.roleScreen);
      }
    } catch (e) {
      scaffoldMessenger("Error removing like: $e");
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  signUp(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    try {
      final res = await _http.mutation(singUpQuery, {
        "signUpObj": {
          "name": nameController.text,
          "email": emailController.text.toLowerCase(),
          "password": passController.text,
          "phone": '$phoneCode${numberController.text}',
          "aphra_registration_number": ahpraRegistrationNumber.text,
          "abn_number": abnNumber.text,
          "type": selectedType?['type'],
          "state": stateController.text,
          "business_name": companyNameController.text,
          "status": selectedType?['type'] == UserRole.supplier.value
              ? "VERIFICATION_PENDING"
              : "VERIFICATION_PENDING",
          "subscription_plan_id": selectedType?['subscription_plan_id'],
          "professionType": selectedCategory?.name,
          "payload": {"subscriptionId": selectedType?['subscription_plan_id']},
          "tracking_details": "Mobile"
        }
      });
      Loaders.circularHideLoader(context);

      if (res.containsKey('_error')) {
        final error = res['_error'].toString();
        if (error.contains('duplicate key') ||
            error.contains('clients_email_key')) {
          scaffoldMessenger(
              "Email already exists. Please use a different email.");
        } else {
          scaffoldMessenger(error);
        }
        return;
      }

      if (res['insert_clients_one'] != null &&
          res['insert_clients_one'].isNotEmpty) {
        SignUpData.fromJson(res);
        /*  selectedType?['type'] == UserRole.supplier.value
            ? supplierUserAlertPopup(context, onBack: () {
                navigationService.pushNamedAndRemoveUntil(RouteList.login);
                clearSignupData();
              })
            :*/
        showSignupSuccessDialog(context, emailController.text, () {
          navigationService.pushNamedAndRemoveUntil(RouteList.login);
          clearSignupData();
        });
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger("Error: $e");
    }
    notifyListeners();
  }

  clearSignupData() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    conformController.clear();
    numberController.clear();
    ahpraRegistrationNumber.clear();
    abnNumber.clear();
    selectedSubscriptionType = null;
    setAgreeToTerms(false);
    selectedType = null;
    stateController.clear();
    companyNameController.clear();
    selectedCategory?.name = null;
    selectedPlanId = null;
    notifyListeners();
  }
}
