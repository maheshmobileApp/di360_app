import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_category.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repo_impl.dart';
import 'package:di360_flutter/feature/learning_hub/repository/learning_hub_repository.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import '../model/filter_section_model.dart';

class FilterViewModel extends ChangeNotifier {
  final LearningHubRepository repo = LearningHubRepoImpl();

  List<String> courseTypeNames = [];
  List<String> courseCategory = [];
  List<FilterItem> courseCategoryItems = [];
  List<CourseCategories> courseCategoryList = [];

  // ✅ Instead of initializing directly, use a getter
  List<FilterSectionModel> get sections => [
        FilterSectionModel(
          title: 'Filter by Type',
          options: courseTypeNames,
        ),
        FilterSectionModel(
          title: 'Category',
          options: courseCategory,
        ),
      ];

  // ✅ Selected options
  final Map<String, String?> selectedOptions = {};

  // ✅ Date & location
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime? selectedDate;

  FilterViewModel() {
    // Initialize keys for each section dynamically
    for (var s in sections) {
      selectedOptions[s.title] = null;
    }
  }

  // -------------------------------
  // 📘 Filter option selection logic
  // -------------------------------
  void selectOption(String title, String? value) {
    selectedOptions[title] = value;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    dateController.text = "${date.day}-${date.month}-${date.year}";
    notifyListeners();
  }

  void updateLocation(String value) {
    locationController.text = value;
    notifyListeners();
  }

  // -------------------------------
  // 📘 API calls
  // -------------------------------
  Future<void> fetchCourseCategory(BuildContext context) async {
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

  Future<void> fetchCourseType(BuildContext context) async {
    final result = await repo.getCourseType();
    courseTypeNames =
        result.courseType?.map((e) => e.name ?? "").toList() ?? [];
    notifyListeners();
  }

  // -------------------------------
  // 📘 Utility methods
  // -------------------------------
  void clearAll() {
    for (var key in selectedOptions.keys) {
      selectedOptions[key] = null;
    }
    dateController.clear();
    locationController.clear();
    selectedDate = null;
    notifyListeners();
  }
}
