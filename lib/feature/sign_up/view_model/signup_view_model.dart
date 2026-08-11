import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/core/base_api_cilent.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/sign_up/model_class/check_mail_res.dart';
import 'package:di360_flutter/feature/sign_up/model_class/get_business_type.dart';
import 'package:di360_flutter/feature/sign_up/model_class/signup_res.dart';
import 'package:di360_flutter/feature/sign_up/model_class/subscription_res.dart';
import 'package:di360_flutter/feature/sign_up/querys/signup_querys.dart';
import 'package:di360_flutter/feature/sign_up/repository/sign_up_repository_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class SignupViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final baseClient = BaseApiClient();
  final SignUpRepositoryImpl signUpRepo = SignUpRepositoryImpl();

  List<SubscriptionData>? subscriptionPlanList;
  List<DirectoryBusinessTypes>? directoryBusinessTypes;
  CheckMailData? checkMailData;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController conformController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController ahpraRegistrationNumber = TextEditingController();
  final TextEditingController abnNumber = TextEditingController();

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

  List<String> phoneCodeList = ConstantData.phoneCodeList;
  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
  }

  void setNumber(String value) {
    _number = value;
    notifyListeners();
  }

  String? selectedSubscriptionPlanId;
  Map<String, String>? selectedType;

  void setSelectedType(Map<String, String>? type) async {
    selectedType = type;
    if (subscriptionPlanList?.isEmpty ?? false) await subscriptionPlans();
    final planList =
        subscriptionPlanList?.where((v) => v.type == type?['type']).toList() ??
            [];
    selectedSubscriptionPlanId = planList.isNotEmpty ? planList.first.id : null;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String? businessTypeId;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    selectedCategorys = null;
    businessTypeId = directoryBusinessTypes?[index].id;
    print("*************************$businessTypeId");
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
      final res = await signUpRepo.getSubscription();
      if (res != null) {
        final data = SubscriptionPlanRes.fromJson(res);
        subscriptionPlanList = data.data;
      }
    } catch (e) {
      scaffoldMessenger("Error removing like: $e");
    }
  }

  businessType(BuildContext context) async {
    Loaders.circularShowLoader(context);
    _selectedIndex = 0;
    try {
      final res = await _http.query(businessQuery,
          variables: {"type": selectedType?['type']}, isTokenRequired: false);
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

  Future<void> checkMail(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final variables = {"email": emailController.text};
    final res = await signUpRepo.checkMail(variables);
    checkMailData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  String getEndPoint(String? type) {
    if (type == UserRole.professional.value) {
      return ApiConst.professionalSignUp;
    } else if (type == UserRole.practice.value) {
      return ApiConst.practiceSignUp;
    } else if (type == UserRole.supplier.value) {
      return ApiConst.supplierSignUp;
    } else {
      return "";
    }
  }

  signUp(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";
    final type = selectedType?['type'];
    final endPoint = getEndPoint(type);
    final businessTypeId = directoryBusinessTypes?[_selectedIndex].id;
    try {
      final res = await baseClient.postCall(endPoint, payload: {
        "name": nameController.text,
        "email": emailController.text.toLowerCase(),
        "phone": '$phoneCode${numberController.text}',
        "professionType": selectedCategory,
        "profession_type_id": selectedCategory?.id,
        "directory_business_type_id": businessTypeId,
        "state": stateController.text,
        "subscription_plan_id": selectedSubscriptionPlanId,
        "tracking_details": "Mobile",
        "password": passController.text,
        "aphra_registration_number": ahpraRegistrationNumber.text,
        "business_name": companyNameController.text,
        "abn_number": abnNumber.text,
        "source": null,
        "zipcode": null,
      });
      final response = SignUpRes.fromJson(res);
      if (response.success == true) {
        showSignupSuccessDialog(context, emailController.text, () {
          navigationService.pushNamedAndRemoveUntil(RouteList.login);
          clearSignupData();
        });
      } else {
        scaffoldMessenger(
            (response.message?.contains("clients_email_key")) ?? false
                ? "Email already exists. Please use a different email."
                : "${response.message}");
      }
      Loaders.circularHideLoader(context);
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
    selectedSubscriptionPlanId = null;
    setAgreeToTerms(false);
    selectedType = null;
    stateController.clear();
    companyNameController.clear();
    selectedCategory?.name = null;
    notifyListeners();
  }
}
