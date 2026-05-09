import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart' hide CourseRegisteredUsers;
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_practices_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_professional_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_supplier_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/repository/market_place_course_reposiotry_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class MarketPlaceLearningHubViewModel extends ChangeNotifier with ValidationMixins {
  final MarketPlaceCourseRepositoryImpl repo =
      MarketPlaceCourseRepositoryImpl();

  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userPhoneNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final userDescriptionController = TextEditingController();
  final searchController = TextEditingController();

  final int _marketPlaceLimit = 10;
  int _marketPlaceOffset = 0;
  bool isLoadingMoreMarketPlace = false;
  bool hasMoreMarketPlace = true;
  String? currentUserId;

  List<CoursesListingDetails> coursesListingList = [];
  List<CoursesListingDetails> marketPlaceCoursesList = [];
  CoursesByPk? courseDetails;
  RegisteredUsersData? registeredUsers;

  String? courseId;
  bool searchBarOpen = false;
  bool editOptionEnable = false;
  bool courseRegistered = false;

  int currentModuleIndex = 0;
  int currentSectionIndex = 0;
  int currentQuizIndex = 0;
  final Map<int, dynamic> quizAnswers = {};
  int? selectedSingleAnswer;
  Set<int> selectedMultipleAnswers = {};
  bool? quizAnswerCorrect;

  void setCourseId(String value) {
    courseId = value;
    notifyListeners();
  }
  String? validateEmailField(String? _) =>
      validateEmail(userEmailController.text);
  String? validatePhoneNum(String? _) =>
      validatePhoneNumber(userPhoneNumberController.text);

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  void setEditOption(bool value) {
    editOptionEnable = value;
    notifyListeners();
  }

  void nextModule() {
    final modules =
        courseDetails?.courseRegisteredUsers?.firstOrNull?.moduleSection;
    final total = modules?.length ?? 0;
    final currentSections = modules?[currentModuleIndex].sectionList ?? [];
    final allCompleted = currentSections.every((s) => s.status == 'Completed');
    if (!allCompleted) {
      scaffoldMessenger("Please complete all sections in this module");
      return;
    }
    if (currentModuleIndex < total - 1) {
      currentModuleIndex++;
      currentSectionIndex = 0;
      notifyListeners();
    }
  }

  void previousModule() {
    if (currentModuleIndex > 0) {
      currentModuleIndex--;
      currentSectionIndex = 0;
      notifyListeners();
    }
  }

  void nextSection() {
    final sections = courseDetails?.courseRegisteredUsers?.firstOrNull
        ?.moduleSection?[currentModuleIndex].sectionList;
    final current = sections?[currentSectionIndex];
    if (current?.status == 'Completed') {
      if (currentSectionIndex < (sections?.length ?? 1) - 1) {
        currentSectionIndex++;
        notifyListeners();
      }
    } else {
      scaffoldMessenger("Please complete the this section");
    }
  }

  void previousSection() {
    if (currentSectionIndex > 0) {
      currentSectionIndex--;
      notifyListeners();
    }
  }

  void nextQuiz() {
    final total = courseDetails?.questionSection?.length ?? 0;
    if (currentQuizIndex < total - 1) {
      currentQuizIndex++;
      _clearQuizSelection();
      notifyListeners();
    }
  }

  void previousQuiz() {
    if (currentQuizIndex > 0) {
      currentQuizIndex--;
      _clearQuizSelection();
      notifyListeners();
    }
  }

  void selectSingleAnswer(int index) {
    if (areAllSectionsCompleted() == false) {
      scaffoldMessenger("Please complete all modules before taking the quiz.");
      return;
    }
    selectedSingleAnswer = index;
    quizAnswers[currentQuizIndex] = index;
    quizAnswerCorrect = null;
    notifyListeners();
  }

  void toggleMultipleAnswer(int index) {
    if (areAllSectionsCompleted() == false) {
      scaffoldMessenger("Please complete all modules before taking the quiz.");
      return;
    }
    if (selectedMultipleAnswers.contains(index)) {
      selectedMultipleAnswers.remove(index);
    } else {
      selectedMultipleAnswers.add(index);
    }
    quizAnswers[currentQuizIndex] = Set<int>.from(selectedMultipleAnswers);
    quizAnswerCorrect = null;
    notifyListeners();
  }

  void verifyQuizAnswer() {
    final question = courseDetails?.questionSection?[currentQuizIndex];
    if (question == null) return;
    final options = question.options ?? [];
    bool isCorrect = false;

    if (question.type == 'single') {
      if (selectedSingleAnswer == null) {
        scaffoldMessenger("Please select an answer");
        return;
      }
      isCorrect = options[selectedSingleAnswer!].isCorrect == true;
    } else {
      if (selectedMultipleAnswers.isEmpty) {
        scaffoldMessenger("Please select at least one answer");
        return;
      }
      final correctIndices = options
          .asMap()
          .entries
          .where((e) => e.value.isCorrect == true)
          .map((e) => e.key)
          .toSet();
      isCorrect = selectedMultipleAnswers.length == correctIndices.length &&
          selectedMultipleAnswers.every((i) => correctIndices.contains(i));
    }

    quizAnswerCorrect = isCorrect;
    scaffoldMessenger(isCorrect ? "Correct Answer! ✅" : "Wrong Answer! ❌");
    notifyListeners();
  }

  (double, bool)? submitQuiz() {
    final questions = courseDetails?.questionSection ?? [];
    if (questions.isEmpty) return null;

    for (int i = 0; i < questions.length; i++) {
      final answer = quizAnswers[i];
      if (answer == null || (answer is Set && answer.isEmpty)) {
        scaffoldMessenger("Please answer all questions before submitting");
        return null;
      }
    }

    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      final options = q.options ?? [];
      final answer = quizAnswers[i];
      bool isCorrect = false;
      if (q.type == 'single') {
        isCorrect = options[answer as int].isCorrect == true;
      } else {
        final selected = answer as Set<int>;
        final correctIndices = options
            .asMap()
            .entries
            .where((e) => e.value.isCorrect == true)
            .map((e) => e.key)
            .toSet();
        isCorrect = selected.length == correctIndices.length &&
            selected.every((idx) => correctIndices.contains(idx));
      }
      if (isCorrect) correctCount++;
    }

    final scored = (correctCount / questions.length) * 100;
    final passPercentage =
        double.tryParse(courseDetails?.passPercentage?.toString() ?? '0') ?? 0;
    final passed = scored >= passPercentage;
    return (scored, passed);
  }

  void resetQuiz() {
    currentQuizIndex = 0;
    quizAnswers.clear();
    _clearQuizSelection();
    notifyListeners();
  }

  Future<void> getAllLearningHubData(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMoreMarketPlace || !hasMoreMarketPlace) return;
      isLoadingMoreMarketPlace = true;
    } else {
      currentUserId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      _marketPlaceOffset = 0;
      hasMoreMarketPlace = true;
    }
    notifyListeners();

    final res = await repo.getMarketPlaceLearningHubData(
        _marketPlaceLimit, _marketPlaceOffset);

    if (loadMore) {
      marketPlaceCoursesList.addAll(res ?? []);
      isLoadingMoreMarketPlace = false;
    } else {
      marketPlaceCoursesList = res ?? [];
    }

    hasMoreMarketPlace = (res?.length ?? 0) >= _marketPlaceLimit;
    _marketPlaceOffset += res?.length ?? 0;
    notifyListeners();
  }

  Future<void> getCourseDetails(BuildContext context, String courseId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getCourseDetails(courseId);
    if (res != null) {
      courseDetails = res;
      currentModuleIndex = 0;
      currentSectionIndex = 0;
      currentQuizIndex = 0;
      quizAnswers.clear();
      _clearQuizSelection();
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> userRegisterToCourse(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    Loaders.circularShowLoader(context);

    final res = await repo.userRegisterToCourse({
      "fields": {
        "course_id": courseId,
        "from_id": userId,
        "type": "SUPPLIER",
        "first_name": userFirstNameController.text,
        "last_name": userLastNameController.text,
        "phone_number": userPhoneNumberController.text,
        "email": userEmailController.text,
        "description": userDescriptionController.text,
        "status": "PENDING",
        "quiz_status": "PENDING",
        "module_section":
            courseDetails?.moduleSection?.map((e) => e.toJson()).toList(),
        "question_section":
            courseDetails?.questionSection?.map((e) => e.toJson()).toList()
      }
    });
    if (res != null) {
      scaffoldMessenger(
        "Successfully Submitted!\nThank you for your interest.\nOur organiser will be in touch with you soon.",
      );
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

   Future<void> registerCourseHandler(
    BuildContext context,
    String createdById
  ) async {
    final isAlreadyRegistered = registeredUsers?.courseRegisteredUsers?.any(
      (user) => user.fromId == createdById,
    );

    validateRegisterCourse(isAlreadyRegistered ?? false);
  }

  void validateRegisterCourse(bool value) {
    courseRegistered = value;
    notifyListeners();
  }

  void _clearQuizSelection() {
    selectedSingleAnswer = null;
    selectedMultipleAnswers = {};
    quizAnswerCorrect = null;
  }

   bool isRegisteredCheck(List<CourseRegisteredUsers>? courseRegisteredUsers) {
    return courseRegisteredUsers?.any((user) => user.fromId == currentUserId) ??
        false;
  }

  bool isCourseDetailRegisteredCheck(
      List<CourseDetailRegisteredUsers>? courseRegisteredUsers) {
    return courseRegisteredUsers?.any((user) => user.fromId == currentUserId) ??
        false;
  }

  Future<void> completeAndContinue(BuildContext context) async {
    final regUser = courseDetails?.courseRegisteredUsers?.firstOrNull;
    if (regUser?.id == null || regUser?.moduleSection == null) return;

    final section = regUser!
        .moduleSection![currentModuleIndex].sectionList?[currentSectionIndex];
    if (section == null || section.status == 'Completed') {
      if (areAllSectionsCompleted()) {
        scaffoldMessenger("Congratulations! You have completed the course.");
      }
      return;
    }

    // Update locally first
    section.status = 'Completed';
    notifyListeners();
    Loaders.circularShowLoader(context);
    // Build payload from the typed model (status is already updated)
    final moduleSectionPayload = regUser.moduleSection!
        .asMap()
        .entries
        .map((entry) => {
              "expanded":
                  entry.key == currentModuleIndex ? true : entry.value.expanded,
              "id": entry.value.id,
              "module_name": entry.value.moduleName,
              "section_list": (entry.value.sectionList ?? [])
                  .map((s) => {
                        "attachment": s.attachment,
                        "course_topic": s.courseTopic,
                        "description": s.description,
                        "expanded": s.expanded,
                        "id": s.id,
                        "image": s.image,
                        "status": s.status,
                        "youtube_link": s.youtubeLink,
                      })
                  .toList(),
            })
        .toList();

    final res = await repo.updatedTheCourseCompletedStatus({
      "id": regUser.id,
      "fields": {"module_section": moduleSectionPayload},
    });

    if (res['insert_course_registered_users_one'] != null) {
      final sections =
          regUser.moduleSection![currentModuleIndex].sectionList ?? [];
      final totalModules = regUser.moduleSection!.length;

      if (areAllSectionsCompleted()) {
        scaffoldMessenger("Congratulations! You have completed the course.");
      }
      if (currentSectionIndex < sections.length - 1) {
        currentSectionIndex++;
      } else if (currentModuleIndex < totalModules - 1) {
        currentModuleIndex++;
        currentSectionIndex = 0;
        regUser.moduleSection![currentModuleIndex].expanded = true;
      }
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  bool areAllSectionsCompleted() {
    final modules =
        courseDetails?.courseRegisteredUsers?.firstOrNull?.moduleSection;
    if (modules == null || modules.isEmpty) return false;
    return modules.every((module) =>
        (module.sectionList ?? []).every((s) => s.status == 'Completed'));
  }

  Future<dynamic> quizSubmitted(BuildContext context) async {
    final res = await repo.markQuizCompleted({
      "id": courseDetails?.courseRegisteredUsers?.firstOrNull?.id ?? '',
      "fields": {
        "quiz_status": "COMPLETED",
        "status": "COMPLETED",
        "completed_date": DateTime.now().toIso8601String().split('T').first
      }
    });
    return res;
  }

  Future<dynamic> getProfile() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await repo.getProfileData();
    if (res != null) {
      _assignProfileData(type, res);
    }
    return res;
  }

  void _assignProfileData(String? type, dynamic res) {
    String? firstName, lastName, email, phone;
    if (type == UserRole.supplier.value) {
      final profile = DentalSuppliersByPk.fromJson(res['dental_suppliers_by_pk'] ?? {});
      firstName = profile.firstName; lastName = profile.lastName;
      email = profile.email; phone = profile.phone;
    } else if (type == UserRole.professional.value) {
      final profile = DentalProfessionalsByPk.fromJson(res['dental_professionals_by_pk'] ?? {});
      firstName = profile.firstName; lastName = profile.lastName;
      email = profile.email; phone = profile.phone;
    } else {
      final profile = DentalPracticesByPk.fromJson(res['dental_practices_by_pk'] ?? {});
      firstName = profile.firstName; lastName = profile.lastName;
      email = profile.email; phone = profile.phone;
    }
    userFirstNameController.text = firstName ?? '';
    userLastNameController.text = lastName ?? '';
    userEmailController.text = email ?? '';
    userPhoneNumberController.text = phone ?? '';
    notifyListeners();
  }


  clearAll() {
    userFirstNameController.text = "";
    userLastNameController.text = "";
    userEmailController.text = "";
    userPhoneNumberController.text = "";
    userDescriptionController.text = "";
  }
}
