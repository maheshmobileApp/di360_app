import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/foundation.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileViewModel(this._repository);

  ProfileSection? _profileSection;
  List<ProfileCategory> _visibleSections = [];
  bool communityStatus = false;

  void updateCommunityStatus(bool status) {
    print("updatedStatus**********************$status");
    communityStatus = status;
    notifyListeners();
  }

  String communityName = "";

  void updateCommunityName(String? name) {
    communityName = name ?? "";
    notifyListeners();
  }

  String? _error;
  ProfileSection? get profileSection => _profileSection;
  List<ProfileCategory> get visibleSections => _visibleSections;
  String? get error => _error;
  Future<void> fetchProfileSections(bool communityStatus) async {
    _error = null;
    try {
      _profileSection = await _repository.getProfileSections();
      await _filterSectionsByRole();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> _filterSectionsByRole() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final communityStatusString =
        await LocalStorage.getStringVal(LocalStorageConst.communityStatus);
    final bool communityStatus = communityStatusString == "true";

    final userRole = UserRole.fromString(type);

    switch (userRole) {
      case UserRole.professional:
        _visibleSections = _profileSection?.roles["PROFESSIONAL"]?.data ?? [];
        break;
      case UserRole.practice:
        _visibleSections = _profileSection?.roles["PRACTICE"]?.data ?? [];
        break;
      case UserRole.supplier:
        _visibleSections = _profileSection?.roles["SUPPLIER"]?.data ?? [];
        _updateSupplierOptions(communityStatus);
        break;
      case UserRole.admin:
        _visibleSections = _profileSection?.roles["ADMIN"]?.data ?? [];
        break;
      default:
        _visibleSections = [];
    }
  }

  void _updateSupplierOptions(bool communityStatus) async {
    final communityName =
        await LocalStorage.getStringVal(LocalStorageConst.communityName);
    print(
        "*********************************************************************************************");
    print("communityStatus : $communityStatus");
    (communityStatus)
        ? _visibleSections = _visibleSections.map((section) {
            if (section.title == "Community") {
              return ProfileCategory(
                title: "${communityName}Community", // new title
                subTitle: section.subTitle,
              );
            }

            if (section.title == "News Feed") {
              return ProfileCategory(
                title: section.title,
                subTitle: section.subTitle.map((subItem) {
                  if (subItem.title.toLowerCase().contains("community")) {
                    return SubTitle(
                      title: "${communityName}Community",
                      asset: subItem.asset,
                    );
                  }
                  return subItem;
                }).toList(),
              );
            }
            return section;
          }).toList()
        :
        // ❌ Remove when FALSE
        _visibleSections.removeWhere((section) => section.title == "Community");

    notifyListeners();
  }
}
