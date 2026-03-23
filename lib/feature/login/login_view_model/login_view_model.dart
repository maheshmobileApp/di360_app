import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_community_owner_res.dart';
import 'package:di360_flutter/feature/login/model_class/get_supplier_model.dart';
import 'package:di360_flutter/feature/login/query/login_querys.dart';
import 'package:di360_flutter/feature/login/repository/login_repo_impl.dart';
import 'package:di360_flutter/feature/login/model_class/login_res.dart';
import 'package:di360_flutter/feature/view_profile/view_model/view_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepoImpl repo = LoginRepoImpl();
  final HttpService _http = HttpService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final Map<String, dynamic> _variables = {
    "details": {"emailOrPhone": "", "password": ""}
  };
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  List<Modules>? modulePermissions = [];

  submit(BuildContext context) async {
    _variables['details']['emailOrPhone'] = emailController.text.toLowerCase();
    _variables['details']['password'] = passController.text;
    if (Map.from(_variables['details']).containsValue("")) {
      scaffoldMessenger("Please fill all the details");
      return "";
    }
    Loaders.circularShowLoader(context);
    try {
      var res = await repo.login(_variables);

      if (res.isNotEmpty && res.containsKey('_error')) {
        Loaders.circularHideLoader(context);
        final err =
            res['_error']?.toString() ?? "Login failed. Please try again.";

        scaffoldMessenger(err == "HasuraRequestError: Invalid credentials"
            ? "Invalid credentials"
            : err);
        return;
      }

      if (res.isNotEmpty && res.containsKey('login_api')) {
        Provider.of<DashBoardViewModel>(context, listen: false).setIndex(0,context);
        if (res['login_api']['status'] == 'ACTIVE' ||
            res['login_api']['status'] == 'UNBLOCKED') {
          final result = LogInData.fromJson(res);
          await getSuppliers(result.loginApi?.id ?? '');

          (result.loginApi?.type == UserRole.supplier.value)
              ? await getSupplierCommunityOwner(result.loginApi?.id ?? '')
              : () {};
          await LocalStorage.setStringVal(
              LocalStorageConst.name, result.loginApi?.name ?? '');
          await LocalStorage.setStringVal(LocalStorageConst.businessName,
              result.loginApi?.businessName ?? '');
          await LocalStorage.setStringVal(
              LocalStorageConst.userId, result.loginApi?.id ?? '');
          await LocalStorage.setStringVal(
              LocalStorageConst.emailId, result.loginApi?.email ?? '');
          await LocalStorage.setStringVal(
              LocalStorageConst.token, result.loginApi?.accessToken ?? '');
          await LocalStorage.setStringVal(
              LocalStorageConst.type, result.loginApi?.type ?? '');
          await LocalStorage.setStringVal(LocalStorageConst.professionType,
              result.loginApi?.professionType ?? '');
          await LocalStorage.setStringVal(
              LocalStorageConst.subType, result.loginApi?.subType ?? '');
          await LocalStorage.setStringVal(LocalStorageConst.subscriptionId,
              result.loginApi?.subscriptionId ?? '');
          await LocalStorage.setBoolValue(LocalStorageConst.profileCompleted,
              result.loginApi?.profileCompleted ?? false);
          await LocalStorage.setStringVal(
              LocalStorageConst.profilePic,
              result.loginApi?.logo?.url ??
                  result.loginApi?.profileImage?.url ??
                  '');
          await LocalStorage.setBoolValue(LocalStorageConst.isAuth, true);
          _modulePermissions(
              result.loginApi?.subscriptionPermissions?.modules ?? []);
          _http.setToken(result.loginApi?.accessToken ?? '');
          updateDevieToken();
          result.loginApi?.profileCompleted == true
              ? homeNavigation()
              : viewProfileHandle(context);
        } else {
          Loaders.circularHideLoader(context);
          scaffoldMessenger('Account is ${res['login_api']['status']}');
        }
      } else {
        Loaders.circularHideLoader(context);
        scaffoldMessenger('Login failed. Please try again.');
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Login failed. Please try again.');
    }
    notifyListeners();
  }

  homeNavigation() async {
    navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
    await LocalStorage.setBoolValue(
        LocalStorageConst.firstNavigationDirectory, true);
    await LocalStorage.setBoolValue(LocalStorageConst.directoryComplete, true);
  }

  viewProfileHandle(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    await context.read<ViewProfileViewModel>().getBusinessTypes();
    await context.read<ViewProfileViewModel>().getTheViewProfileData();
    await LocalStorage.setBoolValue(
        LocalStorageConst.firstNavigationDirectory, true);
    Loaders.circularHideLoader(context);
    type == UserRole.professional.value
        ? await navigationService
            .navigateTo(RouteList.professionalViewProfileScreen)
        : await navigationService.navigateTo(RouteList.viewProfileScreen);
  }

  Future<void> directoryHandling(BuildContext context) async {
    final res = await repo.getDirectory();
    if (res['directories'] == null || (res['directories'] as List).isEmpty) {
      await LocalStorage.setBoolValue(
          LocalStorageConst.firstNavigationDirectory, true);
      await context.read<AddDirectoryViewModel>().fetchTheDirectorData(context);
    } else {
      await LocalStorage.setBoolValue(
          LocalStorageConst.directoryComplete, true);
      navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
    }
    notifyListeners();
  }

  Future<void> updateDevieToken() async {
    try {
      if (!hasListeners) return;
      if (Firebase.apps.isEmpty) return;
      await Future.delayed(Duration(seconds: 2));

      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final deviceToken = await FirebaseMessaging.instance.getToken();

      if (deviceToken != null && userId.isNotEmpty) {
        await LocalStorage.setStringVal(
            LocalStorageConst.deviceToken, deviceToken);
        final variables = {
          "id": userId,
          "device_tokens": [deviceToken]
        };
        await repo.updateDeviceToken(variables);
      }
    } catch (e) {}

    if (hasListeners) {
      notifyListeners();
    }
  }

  getUserDetails() async {
    // Check connectivity first
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return;
    }

    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    var res = await _http.query(
        type == UserRole.supplier.value
            ? getSupplier
            : type == UserRole.practice.value
                ? getPractice
                : type == UserRole.professional.value
                    ? getProfessional
                    : '',
        variables: {"id": userId});
    if (res != null) {
      await LocalStorage.setStringVal(
          LocalStorageConst.profilePic,
          type == UserRole.supplier.value
              ? res['dental_suppliers_by_pk']['profile_image']
              : type == UserRole.practice.value
                  ? res['dental_practices_by_pk']['profile_image']
                  : type == UserRole.professional.value
                      ? res['dental_professionals_by_pk']['profile_image']
                      : '');
    } else {}
    notifyListeners();
  }

  GetSupplierData? supplerData;
  GetSupplierCommunityOwnerData? supplerCommunityOwner;

  Future<void> getSuppliers(String id) async {
    final res = await repo.getSuppliers(id);
    supplerData = res;
    notifyListeners();
  }

  Future<void> getSupplierCommunityOwner(String id) async {
    final res = await repo.getSupplierCommunityOwner(id);
    supplerCommunityOwner = res;

    final supplier = supplerCommunityOwner?.dentalSuppliers?.first;

    if (supplier?.communityStatus == "YES") {
      await LocalStorage.setStringVal(
          LocalStorageConst.communityName, supplier?.businessName ?? '');
      await LocalStorage.setStringVal(
          LocalStorageConst.communityId, supplier?.communityId ?? '');

      await LocalStorage.setStringVal(
          LocalStorageConst.communityStatus, 'true');
      await LocalStorage.setStringVal(
          LocalStorageConst.businessName, supplier?.businessName ?? "");
    } else {
      await LocalStorage.setStringVal(
          LocalStorageConst.communityStatus, 'false');
      await LocalStorage.setStringVal(
          LocalStorageConst.communityId, supplier?.communityId ?? '');
      await LocalStorage.setStringVal(
          LocalStorageConst.communityName, supplier?.businessName ?? '');
      await LocalStorage.setStringVal(
          LocalStorageConst.businessName, supplier?.businessName ?? "");
    }
    notifyListeners();
  }
}

_modulePermissions(List<Modules> modules) async {
  if (modules.isEmpty) {
    return;
  }
  for (var module in modules) {
    switch (module.name) {
      case 'directory_minimal_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.directoryMinimalPermission,
            module.permission ?? false);
        break;
      case 'directory_full_access_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.directoryFullAccessPermission,
            module.permission ?? false);
        break;
      case 'learning_hub_modules_permission':
        await LocalStorage.setBoolValue(LocalStorageConst.learninghubPermission,
            module.permission ?? false);
        break;
      case 'catalogues_modules_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.cataloguePermission, module.permission ?? false);
        break;
      case 'job_seek_modules_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.jobseekPermission, module.permission ?? false);
        break;
      case 'news_feed_modules_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.newsfeedPermission, module.permission ?? false);
        break;
      case 'banner_modules_permission':
        await LocalStorage.setBoolValue(
            LocalStorageConst.bannerPermission, module.permission ?? false);
        break;
      default:
        break;
    }
  }
}
