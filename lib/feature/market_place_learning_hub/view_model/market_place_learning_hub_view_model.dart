import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/get_course_registered_users.dart'
    hide CourseRegisteredUsers;
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_practices_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_professional_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/get_supplier_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/repository/market_place_course_reposiotry_impl.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/my_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketPlaceLearningHubViewModel extends ChangeNotifier
    with ValidationMixins {
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
  bool retakeQuiz = false;
  bool applyFilter = false;

  void updateApplyFilter(bool value) {
    applyFilter = value;
    notifyListeners();
  }

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

  /// Flat list of all sections across all modules in order
  List<SectionDetails> get allSections =>
      courseDetails?.moduleDetails
          ?.expand((m) => m.sectionDetails ?? <SectionDetails>[])
          .toList() ??
      [];

  /// Resolves [currentModuleIndex] from the flat [currentSectionIndex]
  void _syncModuleIndex() {
    final modules = courseDetails?.moduleDetails ?? [];
    int count = 0;
    for (int i = 0; i < modules.length; i++) {
      count += modules[i].sectionDetails?.length ?? 0;
      if (currentSectionIndex < count) {
        currentModuleIndex = i;
        return;
      }
    }
  }

  void nextModule() {
    if (currentSectionIndex < allSections.length - 1) {
      currentSectionIndex++;
      _syncModuleIndex();
      notifyListeners();
    }
  }

  void previousModule() {
    if (currentSectionIndex > 0) {
      currentSectionIndex--;
      _syncModuleIndex();
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

    if (question.questionType == 'single') {
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
    final questions = courseDetails?.quizDetails ?? [];
    if (questions.isEmpty) return null;

    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      final options = q.optionDetails ?? [];
      final answer = quizAnswers[i];
      bool isCorrect = false;
      if (q.type == 'single' || q.type == 'boolean') {
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

  void updateQuizAnswer(int index, dynamic value) {
    quizAnswers[index] = value;
    notifyListeners();
  }

  void resetQuiz() {
    currentQuizIndex = 0;
    quizAnswers.clear();
    retakeQuiz = true;
    _clearQuizSelection();
    notifyListeners();
  }

  Future<void> getAllLearningHubData(BuildContext context,
      {bool loadMore = false,
      List<String>? types,
      List<String>? courseCategory}) async {
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
        _marketPlaceLimit, _marketPlaceOffset, searchController.text,
        types: types, courseCategory: courseCategory);

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
    currentUserId = await LocalStorage.getStringVal(LocalStorageConst.userId);
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
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);

    final res = await repo.userRegisterToCourse({
      "fields": {
        "course_id": courseId,
        "from_id": userId,
        "type": type,
        "first_name": userFirstNameController.text,
        "last_name": userLastNameController.text,
        "phone_number": userPhoneNumberController.text,
        "email": userEmailController.text,
        "description": userDescriptionController.text,
        "status": (courseDetails?.afterwardsPrice == 0 ||
                courseDetails?.afterwardsPrice == null)
            ? "APPROVED"
            : "PENDING",
        "course_registered_date": DateTime.now().toIso8601String(),
        "quiz_status": "PENDING",
        "course_expires_at": courseDetails?.courseAccessDuration != null
            ? DateTime.now()
                .add(Duration(days: courseDetails!.courseAccessDuration!))
                .toIso8601String()
            : null,
        "course_valid_till": courseDetails?.courseAccessDuration,
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
      BuildContext context, String createdById) async {
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
    print("currentUserId: $currentUserId");
    return courseRegisteredUsers?.any((user) => user.fromId == currentUserId) ??
        false;
  }

  Future<void> completeAndContinue(BuildContext context) async {
    final regUser = courseDetails;
    if (regUser?.moduleDetails == null) return;

    final modules = regUser!.moduleDetails!;
    final currentModule = modules[currentModuleIndex];
    final sectionList = currentModule.sectionDetails ?? [];
    if (sectionList.isEmpty) return;
    final prevCount = modules
        .sublist(0, currentModuleIndex)
        .fold<int>(0, (sum, m) => sum + (m.sectionDetails?.length ?? 0));
    final localIndex =
        (currentSectionIndex - prevCount).clamp(0, sectionList.length - 1);
    final section = sectionList[localIndex];

    final moduleId = currentModule.moduleId;
    final modulePosition = currentModule.modulePosition;

    void _advance() {
      if (currentSectionIndex < allSections.length - 1) {
        currentSectionIndex++;
        _syncModuleIndex();
        notifyListeners();
      } else {
        //scaffoldMessenger("You have successfully completed the course");
      }
    }

    // If already completed, just move to next
    if (isSectionCompleted(section.id)) {
      _advance();
      return;
    }

    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    if ((userId.isEmpty) ||
        (moduleId == null || moduleId.isEmpty) ||
        (section.id == null || section.id!.isEmpty) ||
        (regUser.id == null || regUser.id!.isEmpty)) {
      scaffoldMessenger("Missing required data. Please try again.");
      return;
    }

    Loaders.circularShowLoader(context);

    final res = await repo.updatedTheCourseCompletedStatus({
      "fields": {
        "module_name": currentModule.moduleName,
        "expanded": true,
        "module_id": moduleId,
        "course_id": regUser.id,
        "module_position": modulePosition,
        "section_id": section.id,
        "section_status": "Completed",
        "user_id": userId
      }
    });

    if (res['insert_registered_course_module_one'] != null) {
      section.status = 'Completed';
      final registeredUser = courseDetails?.courseRegisteredUsers?.firstOrNull;
      registeredUser?.registeredModuleDetails ??= [];
      final alreadyExists = registeredUser?.registeredModuleDetails
              ?.any((d) => d.sectionId == section.id) ??
          false;
      if (!alreadyExists) {
        registeredUser?.registeredModuleDetails?.add(
          RegisteredModuleDetails(
              sectionId: section.id,
              moduleId: moduleId,
              moduleName: currentModule.moduleName,
              sectionStatus: 'Completed',
              userId: userId),
        );
      }
      _advance();
      if (areAllSectionsCompleted() &&
          (regUser.quizDetails == null || regUser.quizDetails!.isEmpty)) {
        showCourseCompletedDialog(context, () async {
          await quizSubmitted(context, [], isQuizEmpty: true);
          await context
              .read<MyLearningHubViewModel>()
              .getCoursesWithMyRegistrations(context);
          scaffoldMessenger("You have successfully completed the course");
          navigationService.pushNamedAndRemoveUntil(RouteList.dashBoard);
          navigationService.navigateTo(RouteList.myLearningHubScreen);
        });
      }
    }
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  bool isSectionCompleted(String? sectionId) {
    if (sectionId == null) return false;
    return courseDetails?.courseRegisteredUsers?.any(
          (user) =>
              user.registeredModuleDetails?.any(
                (detail) => detail.sectionId == sectionId,
              ) ??
              false,
        ) ??
        false;
  }

  bool areAllSectionsCompleted() {
    final sections = allSections;
    if (sections.isEmpty) return false;
    return sections.every((s) => isSectionCompleted(s.id));
  }

  Future<dynamic> quizSubmitted(
      BuildContext context, List<Map<String, dynamic>> quizAnswersPayload,
      {bool? isQuizEmpty}) async {
    final quizResult = submitQuiz();
    final score = quizResult?.$1 ?? 0;
    final res = await repo.markQuizCompleted({
      "id": courseDetails?.courseRegisteredUsers?.firstOrNull?.id ?? '',
      "fields": {
        "quiz_status": isQuizEmpty == true ? "Not Attempted" : "COMPLETED",
        "status": "COMPLETED",
        "quiz_answers": quizAnswersPayload,
        "quiz_score": score.toStringAsFixed(2),
        "completed_date": DateTime.now().toIso8601String().split('T').first,
        "is_course_completed": true
      }
    });
    if (res['update_course_registered_users_by_pk'] != null) {
      retakeQuiz = false;
    }
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
      final profile =
          DentalSuppliersByPk.fromJson(res['dental_suppliers_by_pk'] ?? {});
      firstName = profile.firstName;
      lastName = profile.lastName;
      email = profile.email;
      phone = profile.phone;
    } else if (type == UserRole.professional.value) {
      final profile = DentalProfessionalsByPk.fromJson(
          res['dental_professionals_by_pk'] ?? {});
      firstName = profile.firstName;
      lastName = profile.lastName;
      email = profile.email;
      phone = profile.phone;
    } else {
      final profile =
          DentalPracticesByPk.fromJson(res['dental_practices_by_pk'] ?? {});
      firstName = profile.firstName;
      lastName = profile.lastName;
      email = profile.email;
      phone = profile.phone;
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
