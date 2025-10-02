import 'package:flutter/material.dart';
import 'package:di360_flutter/feature/my_learning_hub/model/filter_section_model.dart';

class FilterViewModel extends ChangeNotifier {
  final List<FilterSectionModel> sections;

  FilterViewModel({required this.sections});

  final Map<String, String?> _selectedOptions = {};
  Map<String, String?> get selectedOptions => _selectedOptions;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void selectOption(String sectionTitle, String? option) {
    _selectedOptions[sectionTitle] = option;
    notifyListeners();
  }

  void selectDate(DateTime picked) {
    final formattedDate = "${picked.year}-${picked.month}-${picked.day}";
    _selectedOptions["Filter by Date"] = formattedDate;
    dateController.text = formattedDate;
    notifyListeners();
  }

  void updateLocation(String value) {
    _selectedOptions["Filter by Location"] = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void clearAll() {
    _selectedOptions.clear();
    locationController.clear();
    dateController.clear();
    notifyListeners();
  }
}
