import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:flutter/material.dart';

class LearningHubMasterViewModel extends ChangeNotifier with ValidationMixins {
  final LearningHubRepository repo = LearningHubRepoImpl();

  /// Holds available filter options by section (type/category)
  Map<String, List<String>> filterOptions = {};

  bool showLocumDate = false;
  List<DateTime> selectedLocumDatesObjects = [];

  /// Controllers
  final TextEditingController locumDateController = TextEditingController();
  final TextEditingController filterDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  /// Selected string values
  List<String> selectedType = [];
  List<String> selectedCategory = [];
  List<String> selectedCategoryIds = [];

  clearFilterOptions() {
    selectedIndices = {'type': {}, 'category': {}};
    selectedType = [];
    selectedCategory = [];
    selectedCategoryIds = [];
    filterDateController.clear();
    locationController.clear();
    notifyListeners();
  }

  /// Selected checkbox indices for each section
  Map<String, Set<int>> selectedIndices = {
    'type': {},
    'category': {},
  };

  /// Initializes available filter options (only once)
  void initializeFilters({
    required List<String> typeList,
    required List<String> categoryList,
  }) {
    if (filterOptions.isEmpty) {
      filterOptions = {
        'type': typeList,
        'category': categoryList,
      };
      notifyListeners();
    }
  }

  /// Called when a checkbox is toggled
  void selectItem(String section, int index) {
    final currentSet = selectedIndices[section] ?? {};

    // Toggle selection
    if (currentSet.contains(index)) {
      currentSet.remove(index);
    } else {
      currentSet.add(index);
    }

    selectedIndices[section] = currentSet;

    _updateSelectedLists(section);
    notifyListeners();
  }

  /// Updates selected type/category string lists
  void _updateSelectedLists(String section) {
    final items = filterOptions[section];
    if (items == null || items.isEmpty) return;

    if (section == 'type') {
      selectedType =
          selectedIndices['type']!.map((i) => items[i]).toList(growable: false);
    } else if (section == 'category') {
      selectedCategory = selectedIndices['category']!
          .map((i) => items[i])
          .toList(growable: false);
    }

    debugPrint('✅ Selected Types: $selectedType');
    debugPrint('✅ Selected Categories: $selectedCategory');
  }

  /// Clears all filters
  void clearSelections() {
    selectedIndices = {'type': {}, 'category': {}};
    selectedType = [];
    selectedCategory = [];
    filterDateController.clear();
    locationController.clear();
    notifyListeners();
  }

  Future<void> setSelectedCourseCategories(List<String> selectedNames) async {
    // Make sure you have latest categories
    await fetchCourseCategory();

    // Clear existing selections
    selectedCategoryIds = [];

    // Map each selected name to its ID
    for (final name in selectedNames) {
      final match = courseCategoryList.firstWhere(
        (course) => course.name == name,
        orElse: () => CourseCategories(),
      );

      if (match.id != null && match.id!.isNotEmpty) {
        selectedCategoryIds.add(match.id!);
      }
    }

    // Optionally keep selected names if you still need them for UI
    //selectedCategoryNames = selectedNames;

    notifyListeners();
  }

  List<CourseCategories> courseCategoryList = [];
  List<String> courseCategory = [];
  List<FilterItem> courseCategoryItems = [];
  Future<void> fetchCourseCategory() async {
    final result = await repo.getCourseCategory();
    courseCategoryList = result.courseCategories ?? [];
    courseCategoryList.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
    courseCategory = courseCategoryList.map((e) => e.name ?? "").toList();
    courseCategoryItems = courseCategoryList
        .where((e) => e.id != null && e.name != null)
        .map((e) => FilterItem(id: e.id!, name: e.name!))
        .toList();
    notifyListeners();
  }
}
