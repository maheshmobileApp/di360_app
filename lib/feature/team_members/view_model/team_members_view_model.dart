import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/team_members/model/get_sub_supplier_res.dart';
import 'package:di360_flutter/feature/team_members/model/get_team_members_res.dart';
import 'package:di360_flutter/feature/team_members/repository/team_members_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class TeamMembersViewModel extends ChangeNotifier {
  final TeamMembersRepoImpl repo = TeamMembersRepoImpl();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool editMode = false;
  String editedId = "";
  void setEditMode(bool val) {
    editMode = val;
    notifyListeners();
  }

  void setEditedId(String val) {
    editedId = val;
    notifyListeners();
  }

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isConfirmPasswordVisible = false;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  List<String> permissionOptions = [
    "Directory Minimal",
    "Directory Full Access",
    "Catalogues",
    "Learning Hub Access",
    "Job Seek",
    "News Feed",
    "Banner"
  ];

  final List<String> _selectedPermissionChips = [];
  List<String> get selectedPermissionChips =>
      List.unmodifiable(_selectedPermissionChips);
  void removePermissionTypeChip(String empType) {
    _selectedPermissionChips.remove(empType);
    notifyListeners();
  }

  void addPermissionTypeChip(String empType) {
    if (!_selectedPermissionChips.contains(empType)) {
      // If adding "Directory Full Access", remove "Directory Minimal"
      if (empType == "Directory Full Access") {
        _selectedPermissionChips.remove("Directory Minimal");
      }
      // If adding "Directory Minimal", remove "Directory Full Access"
      if (empType == "Directory Minimal") {
        _selectedPermissionChips.remove("Directory Full Access");
      }
      _selectedPermissionChips.add(empType);
      notifyListeners();
    }
  }

  TeamMembersData? teamMembersData;

  Future<void> getTeamMembers() async {
    print("**************************************getTeamMembers");
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "where": {
        "supplier_access_id": {"_eq": id}
      },
      "limit": 100,
      "offset": 0
    };
    final res = await repo.getTeamMembers(variables);
    if (res.clients?.length != 0) {
      teamMembersData = res;
    } else {
      teamMembersData = res;
    }
    notifyListeners();
  }

  Future<void> deleteTeamMember(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    final res = await repo.deleteTeamMember(variables);
    if (res != null) {
      await deleteSupplierAccess(id);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteSupplierAccess(String id) async {
    final variables = {
      "where": {
        "owner_id": {"_eq": id}
      }
    };
    final res = await repo.deleteSupplierAccess(variables);
    if (res != null) {
      scaffoldMessenger("Team Member Successfully Deleted");
      getTeamMembers();
    }
    notifyListeners();
  }

  ClientsByPk? getSubSupplierData;
  Future<void> getSubSupplier(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    final res = await repo.getSubSupplier(variables);
    if (res.clientsByPk != null) {
      getSubSupplierData = res.clientsByPk;
      editTeamMemberData(getSubSupplierData);
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  editTeamMemberData(ClientsByPk? data) {
    userNameController.text = data?.name ?? "";
    emailController.text = data?.email ?? "";
    phoneController.text = data?.phone ?? "";
    passwordController.text = data?.password ?? "";
    confirmPasswordController.text = data?.password ?? "";

    // Clear existing permissions
    _selectedPermissionChips.clear();

    // Add permissions based on API response
    if (data?.permissions?.modules != null) {
      for (var module in data!.permissions!.modules!) {
        if (module.permission == true) {
          switch (module.name) {
            case "directory_minimal_permission":
              _selectedPermissionChips.add("Directory Minimal");
              break;
            case "directory_full_access_permission":
              _selectedPermissionChips.add("Directory Full Access");
              break;
            case "catalogues_modules_permission":
              _selectedPermissionChips.add("Catalogues");
              break;
            case "learning_hub__modules_permission":
              _selectedPermissionChips.add("Learning Hub Access");
              break;
            case "job_seek_modules_permission":
              _selectedPermissionChips.add("Job Seek");
              break;
            case "news_feed_modules_permission":
              _selectedPermissionChips.add("News Feed");
              break;
            case "banner_modules_permission":
              _selectedPermissionChips.add("Banner");
              break;
          }
        }
      }
    }

    notifyListeners();
  }

  Future<void> createTeamMember(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final businessName =
        await LocalStorage.getStringVal(LocalStorageConst.businessName);
    final professionType =
        await LocalStorage.getStringVal(LocalStorageConst.type);
    final subscriptionPlanId =
        await LocalStorage.getStringVal(LocalStorageConst.subscriptionId);
    final variables = {
      "signUpObj": {
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "name": userNameController.text,
        "sub_type": "SUB_SUPPLIER",
        "type": "SUPPLIER",
        "supplier_access_id": id,
        "business_name": businessName,
        "professionType": "Dental  Community",
        "subscription_plan_id": subscriptionPlanId,
        "community_id": null,
        "community_status": null,
        "permissions": {
          "modules": [
            {
              "name": "directory_minimal_permission",
              "permission":
                  _selectedPermissionChips.contains("Directory Minimal"),
              "count": 0
            },
            {
              "name": "directory_full_access_permission",
              "permission":
                  _selectedPermissionChips.contains("Directory Full Access"),
              "count": 0
            },
            {
              "name": "catalogues_modules_permission",
              "permission": _selectedPermissionChips.contains("Catalogues"),
              "count": 1
            },
            {
              "name": "learning_hub__modules_permission",
              "permission":
                  _selectedPermissionChips.contains("Learning Hub Access"),
              "count": 1
            },
            {
              "name": "job_seek_modules_permission",
              "permission": _selectedPermissionChips.contains("Job Seek"),
              "count": 1
            },
            {
              "name": "news_feed_modules_permission",
              "permission": _selectedPermissionChips.contains("News Feed"),
              "count": 1
            },
            {
              "name": "banner_modules_permission",
              "permission": _selectedPermissionChips.contains("Banner"),
              "count": 1
            }
          ]
        },
        "status": "VERIFICATION_PENDING"
      }
    };
    print("variables:*****************$variables");
    final res = await repo.createTeamMember(variables);
    if (res != null) {
      Loaders.circularHideLoader(context);
      await getTeamMembers();
      navigationService.goBack();
      clearFields();
      scaffoldMessenger("Team Member Created Sucessfully!");
    }
    notifyListeners();
  }

  Future<void> updateTeamMember(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final businessName =
        await LocalStorage.getStringVal(LocalStorageConst.businessName);
    final professionType =
        await LocalStorage.getStringVal(LocalStorageConst.type);
    final subscriptionPlanId =
        await LocalStorage.getStringVal(LocalStorageConst.subscriptionId);
    final variables = {
      "id": editedId,
      "fields": {
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "name": userNameController.text,
        "sub_type": "SUB_SUPPLIER",
        "type": "SUPPLIER",
        "supplier_access_id": id,
        "business_name": businessName,
        "professionType": "Dental  Community",
        "subscription_plan_id": subscriptionPlanId,
        "community_id": null,
        "community_status": null,
        "permissions": {
          "modules": [
            {
              "name": "directory_minimal_permission",
              "permission":
                  _selectedPermissionChips.contains("Directory Minimal"),
              "count": 0
            },
            {
              "name": "directory_full_access_permission",
              "permission":
                  _selectedPermissionChips.contains("Directory Full Access"),
              "count": 0
            },
            {
              "name": "catalogues_modules_permission",
              "permission": _selectedPermissionChips.contains("Catalogues"),
              "count": 1
            },
            {
              "name": "learning_hub__modules_permission",
              "permission":
                  _selectedPermissionChips.contains("Learning Hub Access"),
              "count": 1
            },
            {
              "name": "job_seek_modules_permission",
              "permission": _selectedPermissionChips.contains("Job Seek"),
              "count": 1
            },
            {
              "name": "news_feed_modules_permission",
              "permission": _selectedPermissionChips.contains("News Feed"),
              "count": 1
            },
            {
              "name": "banner_modules_permission",
              "permission": _selectedPermissionChips.contains("Banner"),
              "count": 1
            }
          ]
        }
      }
    };
    print("variables:*****************$variables");
    final res = await repo.updateTeamMember(variables);
    if (res != null) {
      editedId = '';
      Loaders.circularHideLoader(context);
      await getTeamMembers();
      navigationService.goBack();
      clearFields();
      scaffoldMessenger("Team Member Updated Sucessfully!");
    }
    notifyListeners();
  }

  clearFields() {
    userNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _selectedPermissionChips.clear();
  }
}
