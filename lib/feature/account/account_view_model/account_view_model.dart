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

  String? _error;
  ProfileSection? get profileSection => _profileSection;
  List<ProfileCategory> get visibleSections => _visibleSections;
  String? get error => _error;
  Future<void> fetchProfileSections() async {
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
        break;
      case UserRole.admin:
        _visibleSections = _profileSection?.roles["ADMIN"]?.data ?? [];
        break;
      default:
        _visibleSections = [];
    }
  }
}
