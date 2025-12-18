import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/sign_up/model_class/get_business_type.dart';
import 'package:di360_flutter/feature/sign_up/model_class/signup_res.dart';
import 'package:di360_flutter/feature/sign_up/model_class/subscription_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
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
  final TextEditingController postalCodeController = TextEditingController();

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

  businessType() async {
    _selectedIndex = 0;
    try {
      final res = await _http
          .query(businessQuery, variables: {"type": selectedSubscriptionType});
      if (res != null) {
        final data = BusinessData.fromJson(res);
        directoryBusinessTypes = data.directoryBusinessTypes;
        navigationService.navigateTo(RouteList.roleScreen);
      }
    } catch (e) {
      scaffoldMessenger("Error removing like: $e");
    }
    notifyListeners();
  }

  signUp(BuildContext context) async {
    Loaders.circularShowLoader(context);
    try {
      
      final res = await _http.mutation(singUpQuery, {
        "signUpObj": {
          "name": nameController.text,
          "email": emailController.text,
          "password": passController.text,
          "phone": numberController.text,
          "postal_code": postalCodeController.text,
          "type": selectedType?['type'],
          "state": stateController.text,
          "business_name": companyNameController.text,
          "status": "PENDING",
          "subscription_plan_id": selectedPlanId,
          "professionType": selectedCategory?.name
        }
      });
      if (res.isNotEmpty) {
        final result = SignUpData.fromJson(res);
        await LocalStorage.setStringVal(
            LocalStorageConst.name, result.insertClientsOne?.name ?? '');
        await LocalStorage.setStringVal(
            LocalStorageConst.userId, result.insertClientsOne?.id ?? '');
        await LocalStorage.setStringVal(
            LocalStorageConst.type, result.insertClientsOne?.type ?? '');
        await LocalStorage.setBoolValue(LocalStorageConst.isAuth, true);
        Loaders.circularHideLoader(context);
        showSignupSuccessDialog(context, emailController.text, () {
          navigationService.pushNamedAndRemoveUntil(RouteList.login);
        });
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger("Error removing like: $e");
    }
    notifyListeners();
  }
}

const String subscriptionQuery = '''
    query getSubPlan {
      subscription_plans(
        where: {plan_type: {_eq: "REGULAR"}, plan_status: {_eq: "ACTIVE"}}
      ) {
        id
        updated_at
        name
        price_in_aud
        price_in_usd
        tenure_in_days
        tenure_type
        terms_and_conditions
        type
        description
        benefits
        plan_type
        monthy_price
        yearly_price
        plan_status
        __typename
      }
    }
  ''';

const String businessQuery = '''
      query getBusinessTypes(\$type: String!) {
  directory_business_types(where: {type: {_eq: \$type}}) {
    id
    type
    name
    directory_categories {
      id
      name
      __typename
    }
    __typename
  }
}
  ''';

const String singUpQuery = '''
mutation signUp(\$signUpObj: clients_insert_input!) {  insert_clients_one(object: \$signUpObj) {  
  id    
  email   
   phone
   type
   name   
    __typename}

}
  ''';