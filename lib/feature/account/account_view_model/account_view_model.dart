import 'package:flutter/foundation.dart';
import 'package:di360_flutter/feature/account/account_model/account_model.dart';
import 'package:di360_flutter/feature/account/repository/account_repository.dart';

class AccountViewModel extends ChangeNotifier {
  final AccountRepository accountRepository;

  AccountViewModel(this.accountRepository);

  List<AccountSection> _sections = [];
  bool _isLoading = false;

  List<AccountSection> get sections => _sections;
  bool get isLoading => _isLoading;

  /// Loads account sections from the repository (e.g., local JSON)
  Future<void> loadAccountData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sections = await accountRepository.getAccountSections();
    } catch (e) {
      debugPrint("Error loading account sections: $e");
      _sections = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Optional tap handler for future navigation
  void onSectionItemTap(String sectionTitle, String itemTitle) {
    debugPrint("Tapped on $itemTitle from $sectionTitle");
    // Navigation or logic can be added here if needed
  }
}