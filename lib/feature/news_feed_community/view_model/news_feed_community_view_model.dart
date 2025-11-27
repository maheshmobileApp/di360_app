import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';
import 'package:di360_flutter/feature/news_feed_community/repository/news_feed_community_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewsFeedCommunityViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final NewsFeedCommunityRepoImpl repo = NewsFeedCommunityRepoImpl();

  NewsFeedCommunityData? newsFeedCommunityData;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();

  bool isEditNewsFeed = false;
  List<String> newsFeedCategory = [];

  String? selectedCategory;
  String? selectedCategoryId;

  List<NewsfeedCategories>? newsfeedCategories;

  List<String>? serverNewsFeedGallery;
  List<File>? selectedNewsFeedGallery;
  List<CourseBannerImage> selectedNewsFeedGalleryList = [];

  String selectedStatus = "Published";
  String listingStatus = "PUBLISHED";

  final List<String> statuses = [
    'Pending Approval',
    "Published",
    'Unpublished'
  ];

  int? pendingCount = 0;
  int? publishedCount = 0;
  int? unPublishedCount = 0;

  Map<String, int?> get statusCountMap => {
        'PUBLISHED': publishedCount,
        'UNPUBLISHED': unPublishedCount,
        'PENDING': pendingCount,
      };

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'Pending Approval') {
      listingStatus = "PENDING";
    } else if (status == 'Published') {
      listingStatus = 'PUBLISHED';
    } else if (status == 'Unpublished') {
      listingStatus = 'UNPUBLISHED';
    }

    getAllNewsFeeds(context);
    notifyListeners();
    //INACTIVE
  }

  void setEditNewsFeed(bool value) {
    isEditNewsFeed = value;
    notifyListeners();
  }

  void setServerNewsFeedGallery(List<String>? value) {
    serverNewsFeedGallery = value;
    notifyListeners();
  }

  void setNewsFeedGallery(List<File>? value) {
    selectedNewsFeedGallery = value;
    notifyListeners();
  }

  Future<List<T>> uploadFiles<T>(
    List<File>? files,
    T Function(File, Map<String, dynamic>) builder,
  ) async {
    if (files == null || files.isEmpty) return [];

    final List<T> uploaded = [];

    for (var file in files) {
      final response = await _http.uploadImage(file.path);

      uploaded.add(builder(file, response));
    }
    return uploaded;
  }

  Future<void> validateNewsFeedGallery() async {
    // Otherwise upload the new images
    selectedNewsFeedGalleryList = await uploadFiles(
      selectedNewsFeedGallery,
      (file, res) => CourseBannerImage(
        name: file.path.split('/').last,
        url: res['url'],
        type: res['type'] ?? "image/jpeg",
        size: res['size'] ?? file.lengthSync(),
      ),
    );

    notifyListeners();
  }

  String profCommunityId = "";
  void setProfCommunityId(String value) {
    profCommunityId = value;
    notifyListeners();
  }

  //GET JOIN REQUEST
  Future<void> getAllNewsFeeds(BuildContext context) async {
    Loaders.circularShowLoader(context);
    print("*************************************GetAllNewsFeeds Calling");
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "status": {"_eq": listingStatus},
        "community_id": {
          "_eq": (type == "PROFESSIONAL") ? profCommunityId : communityId
        }
      },
      "limit": 100,
      "offset": 0,
      "userId": userId,
      "roleType": type
    };
    print("************get all news feed variables: $variables");

    final res = await repo.getAllNewsFeeds(variables);
    if (res != null) {
      print("*************************************data fetched successfully");
      newsFeedCommunityData = res;

      Loaders.circularHideLoader(context);
    }

    notifyListeners();
  }

  Future<void> stausCount(String status) async {
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final variables = {
      "where": {
        "community_id": {"_eq": communityId},
        "status": {"_eq": status}
      }
    };
    print("variables: $variables");
    final res = await repo.feedCount(variables);
    if (res != null) {
      final count = res.newsfeedsAggregate?.aggregate?.count ?? 0;

      switch (status) {
        case "PENDING":
          pendingCount = count;
          break;
        case "PUBLISHED":
          publishedCount = count;
          break;
        case "UNPUBLISHED":
          unPublishedCount = count;
          break;
      }
    }
    notifyListeners();
  }

  //Get all status counts
  Future<void> getAllStatusCounts() async {
    print("*************************************Status count Calling");
    await stausCount("PENDING");
    await stausCount("PUBLISHED");
    await stausCount("UNPUBLISHED");
  }

  //LIKE
  Future<void> communityLike(BuildContext context, [String? newsFeedId]) async {
    print("*************************************CommunityLike Calling");
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "fields": {
        "news_feeds_id": newsFeedId,
        "role_type": type,
        "dental_supplier_id": userId
      }
    };
    final res = await repo.communityLike(variables);
    if (res != null) {
      scaffoldMessenger("Liked Successfully");
    }
    getAllNewsFeeds(context);
    notifyListeners();
  }

  List uploadedFiles = [];
  //Add news feed
  Future<void> addNewsFeed(
      BuildContext context, String dentalSupplierId) async {
    Loaders.circularShowLoader(context);
    await validateNewsFeedGallery();
    print("*************************************add feed Calling");
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);

    final variables = {
      "fields": {
        "description": descriptionController.text,
        "category_type":
            selectedCategoryId, //"890535a3-83eb-4d6e-ad5b-606aeaeaa205",
        "video_url": videoLinkController.text,
        "post_image": selectedNewsFeedGalleryList,
        "web_url": websiteLinkController.text,
        "user_role": type,
        "user_id": userId,
        "status": "PUBLISHED",
        "dental_supplier_id": (type == "SUPPLIER")
            ? userId
            : dentalSupplierId, //"5e3c1d29-f7bf-4463-b868-83fbdcdd148b",
        "feed_type": "NEWSFEED",
        "community_id": communityId
      }
    };

    print(
        "***************************************************variables: $variables");
    final res = await repo.addNewsFeed(variables);
    if (res.isNotEmpty) {
      uploadedFiles.clear();
      scaffoldMessenger('Newsfeed submitted successfully');

      navigationService.goBack();
    }

    getAllNewsFeeds(context);
    Loaders.circularHideLoader(context);
    clearAddNewsFeedData();

    notifyListeners();
  }

  clearAddNewsFeedData() {
    descriptionController.clear();
    videoLinkController.clear();
    websiteLinkController.clear();
    selectedFiles.clear();
    serverNewsFeedGallery = null;
    selectedNewsFeedGallery = null;
    selectedCategory = null;
  }

  // UN LIKE
  Future<void> communityUnLike(BuildContext context, [String? likeId]) async {
    print("*************************************CommunityUnLike Calling");
    final variables = {"id": likeId ?? "42543249-80cc-4c4a-b878-e871023e3944"};
    final res = await repo.communityUnLike(variables);
    if (res != null) {
      scaffoldMessenger("Unliked Successfully");
    }
    getAllNewsFeeds(context);
    notifyListeners();
  }

  // Update news feed status
  Future<void> updateNewsFeedStatus(
      BuildContext context, String id, String status) async {
    print("***************************updateNewsFeedStatus Calling");
    final variables = {"id": id, "status": status};
    print("***************************variavles $variables");

    final res = await repo.updateNewsFeedStatus(variables);
    if (res != null) {
      (status == "PUBLISHED")
          ? scaffoldMessenger("News Feed Published Successfully")
          : scaffoldMessenger("News Feed Un-Published Successfully");
    }
    getAllNewsFeeds(context);
    //getAllStatusCounts();
    notifyListeners();
  }
  /******************News Feed Upload ************************ */

  List existingImages = [];
  List<PlatformFile> selectedFiles = [];
  void removeExistingFile(int index) {
    existingImages.removeAt(index);
    notifyListeners();
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
    notifyListeners();
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'mp4', 'mov', 'avi'],
    );

    if (result != null) {
      selectedFiles.addAll(result.files);
      notifyListeners();
    }
  }

  NewsFeedCategoriesData? newsFeedCategoriesData;

  void setSelectedNewsFeedCategory(String? name) {
    selectedCategory = name;

    if (name != null && newsFeedCategoriesData?.newsfeedCategories != null) {
      final match = newsFeedCategoriesData!.newsfeedCategories!.firstWhere(
        (category) => category.categoryName == name,
        orElse: () => NewsfeedCategories(),
      );
      selectedCategoryId = match.id;
    } else {
      selectedCategoryId = null;
    }

    notifyListeners();
  }

  /*********************Update & Delete Community */

  Future<void> updateNewsFeedCommunity(BuildContext context, String id,
      String communityId, String dentalProfessionalId) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "id": id,
      "fields": {
        "description": descriptionController.text,
        "category_type": selectedCategoryId,
        "video_url": videoLinkController.text,
        "post_image": selectedNewsFeedGalleryList,
        "web_url": websiteLinkController.text,
        "user_role": type,
        "user_id": userId,
        "status": "PUBLISHED",
        "dental_professional_id": dentalProfessionalId,
        "feed_type": "NEWSFEED",
        "community_id": communityId
      }
    };

    print("***************************variavles $variables");

    final res = await repo.updateNewsFeedCommunity(variables);
    if (res != null) {
      scaffoldMessenger("News Feed Updated Successfully");
    }
    getAllNewsFeeds(context);
    //getAllStatusCounts();
    notifyListeners();
  }

  Future<void> deleteNewsFeedCommunity(BuildContext context, String id) async {
    final variables = {"id": id};

    print("***************************variavles $variables");

    final res = await repo.deleteNewsFeedCommunity(variables);
    if (res != null) {
      scaffoldMessenger("News Feed Deleted Successfully");
    }
    getAllNewsFeeds(context);
    //getAllStatusCounts();
    notifyListeners();
  }
}
