import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repository.dart';
import 'package:flutter/foundation.dart';


class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileViewModel(this._repository);

  List<ProfileSection> _sections = [];
  bool _isLoading = false;
  String? _error;

  List<ProfileSection> get sections => _sections;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProfileSections() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sections = await _repository.getProfileSections();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
