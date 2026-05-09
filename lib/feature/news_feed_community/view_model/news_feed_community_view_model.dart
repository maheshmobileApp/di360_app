import 'dart:io';

import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/news_feed_community/model/banner_url_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';
import 'package:di360_flutter/feature/news_feed_community/repository/news_feed_community_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewsFeedCommunityViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final NewsFeedCommunityRepoImpl repo = NewsFeedCommunityRepoImpl();

  NewsFeedCommunityData? newsFeedCommunityData;
  int _currentPage = 0;
  bool _hasMoreNewsFeeds = true;
  bool _isLoadingMore = false;
  final int _newsFeedLimit = 10;

  bool get hasMoreNewsFeeds => _hasMoreNewsFeeds;
  bool get isLoadingMore => _isLoadingMore;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController videoLinkController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();

  bool isEditNewsFeed = false;
  List<String> newsFeedCategory = [];

  String? selectedCategory;
  String? selectedCategoryId;
  bool searchBarOpen = false;
  TextEditingController searchController = TextEditingController();
  void setSelectedCategoryId(String value) {
    selectedCategoryId = value;
    notifyListeners();
  }

  bool applyFilter = false;

  void updateApplyFilter(bool val) {
    applyFilter = val;
    notifyListeners();
  }

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  List<NewsfeedCategories>? newsfeedCategories;

  List<String>? serverNewsFeedGallery;
  List<File>? selectedNewsFeedGallery;
  List<CourseBannerImage> selectedNewsFeedGalleryList = [];
  /************************************** */
  TextEditingController commentController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();

  bool isReply = false;
  String? commentId;
  String? commenterName;
  bool replyCommentUpdate = false;
  bool commentUpdate = false;
  bool removeReplyFeild = false;
  String? hintText;
  void updateHintText(String? hinttext, {bool? removeReplyVal}) {
    hintText = hinttext;
    removeReplyFeild = removeReplyVal ?? false;
    notifyListeners();
  }

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
        'Published': publishedCount,
        'Unpublished': unPublishedCount,
        'Pending Approval': pendingCount,
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
  String profCommunityName = "";
  void setProfCommunityId(String id, String name) {
    profCommunityId = id;
    profCommunityName = name;
    notifyListeners();
  }

  Future<void> getAllNewsFeeds(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore && (_isLoadingMore || !_hasMoreNewsFeeds)) return;

    if (loadMore) {
      _isLoadingMore = true;
    } else {
      _currentPage = 0;
      _hasMoreNewsFeeds = true;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "status": {"_eq": listingStatus},
        "community_id": {
          "_eq": (type == UserRole.professional.value) ? profCommunityId : communityId
        },
        if (searchController.text.isNotEmpty && searchBarOpen)
          "_or": [
            {
              "description": {"_ilike": "%${searchController.text}%"}
            },
            {
              "title": {"_ilike": "%${searchController.text}%"}
            },
            {
              "admin_user": {
                "name": {"_ilike": "%${searchController.text}%"}
              }
            },
            {
              "dental_practice": {
                "business_name": {"_ilike": "%${searchController.text}%"}
              }
            },
            {
              "dental_supplier": {
                "business_name": {"_ilike": "%${searchController.text}%"}
              }
            },
            {
              "dental_professional": {
                "name": {"_ilike": "%${searchController.text}%"}
              }
            }
          ]
      },
      "limit": _newsFeedLimit,
      "offset": _currentPage * _newsFeedLimit,
      "userId": userId,
      "roleType": type
    };

    final res = await repo.getAllNewsFeeds(variables);

    if (loadMore) {
      newsFeedCommunityData?.newsfeeds?.addAll(res.newsfeeds ?? []);
    } else {
      newsFeedCommunityData = res;
    }

    _hasMoreNewsFeeds = (res.newsfeeds?.length ?? 0) >= _newsFeedLimit;
    if ((res.newsfeeds?.length ?? 0) > 0) {
      _currentPage++;
    }

    if (!loadMore) {
      Loaders.circularHideLoader(context);
    }
    (type == UserRole.supplier.value) ? getAllStatusCounts() : () {};

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> filterNewsFeeds(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore && (_isLoadingMore || !_hasMoreNewsFeeds)) return;

    if (loadMore) {
      _isLoadingMore = true;
    } else {
      _currentPage = 0;
      _hasMoreNewsFeeds = true;
      Loaders.circularShowLoader(context);
    }
    notifyListeners();

    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "status": {"_eq": listingStatus},
        "category_type": {
          "_in": [selectedCategoryId]
        },
        "community_id": {
          "_eq": (type == UserRole.professional.value) ? profCommunityId : communityId
        }
      },
      "limit": _newsFeedLimit,
      "offset": _currentPage * _newsFeedLimit,
      "userId": userId,
      "roleType": type
    };

    final res = await repo.filterNewsFeed(variables);

    if (loadMore) {
      newsFeedCommunityData?.newsfeeds?.addAll(res.newsfeeds ?? []);
    } else {
      newsFeedCommunityData = res;
      updateApplyFilter(true);
    }

    _hasMoreNewsFeeds = (res.newsfeeds?.length ?? 0) >= _newsFeedLimit;
    if ((res.newsfeeds?.length ?? 0) > 0) {
      _currentPage++;
    }

    if (!loadMore) {
      Loaders.circularHideLoader(context);
    }
    (type == UserRole.supplier.value) ? getAllStatusCounts() : () {};

    _isLoadingMore = false;
    notifyListeners();
  }

  FeedCountData? feedCountData;

  Future<void> getAllStatusCounts() async {
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final variables = {
      "community_id": communityId,
    };

    final res = await repo.feedCount(variables);
    feedCountData = res;
    pendingCount = feedCountData?.pending?.aggregate?.count;
    publishedCount = feedCountData?.published?.aggregate?.count;
    unPublishedCount = feedCountData?.unpublished?.aggregate?.count;
    notifyListeners();
  }

  //LIKE
  Future<void> communityLike(BuildContext context, [String? newsFeedId]) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final Map<String, dynamic> fields = {
      "news_feeds_id": newsFeedId,
      "role_type": type,
    };

    if (type == UserRole.professional.value) {
      fields["dental_professional_id"] = userId;
    } else {
      fields["dental_supplier_id"] = userId;
    }

    final variables = {"fields": fields};

    final res = await repo.communityLike(variables);
    if (res != null) {
      scaffoldMessenger("Liked Successfully");
    }
    getAllNewsFeeds(context);
    notifyListeners();
  }

  List uploadedFiles = [];
  //Add news feed
  Future<void> addNewsFeed(BuildContext context) async {
    print("*************************************add feed Calling");
    Loaders.circularShowLoader(context);
    await validateNewsFeedGallery();

    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    for (var element in selectedFiles) {
      var value = await _http.uploadImage(element.path);
      print("resp from upload $value");
      if (value != null) {
        uploadedFiles.add(value);
      }
    }

    final Map<String, dynamic> fields = {
      "description": descriptionController.text,
      "category_type": selectedCategoryId,
      "video_url": videoLinkController.text,
      "post_image": uploadedFiles,
      "web_url": websiteLinkController.text,
      "user_role": type,
      "user_id": userId,
      "status": (type == UserRole.professional.value) ? "PENDING" : "PUBLISHED",
      "feed_type": "NEWSFEED",
      "community_id": (type == UserRole.professional.value) ? profCommunityId : communityId,
    };

    if (type == UserRole.professional.value) {
      fields["dental_professional_id"] = userId;
    } else {
      fields["dental_supplier_id"] = userId;
    }

    final variables = {"fields": fields};

    final res = await repo.addNewsFeed(variables);
    if (res.isNotEmpty) {
      await getAllNewsFeeds(context);
      Loaders.circularHideLoader(context);

      scaffoldMessenger('Newsfeed submitted successfully');

      navigationService.goBack();
      uploadedFiles.clear();
    }

    clearAddNewsFeedData();

    notifyListeners();
  }

  clearAddNewsFeedData() {
    descriptionController.clear();
    videoLinkController.clear();
    websiteLinkController.clear();
    selectedFiles.clear();
    existingImages.clear();
    uploadedFiles.clear();
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
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
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
    (type == UserRole.supplier.value) ? getAllStatusCounts() : () {};
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
    print("****************Calling name to Id $name");
    selectedCategory = name;

    if (name != null && newsFeedCategoriesData?.newsfeedCategories != null) {
      final match = newsFeedCategoriesData!.newsfeedCategories!.firstWhere(
        (category) => category.categoryName == name,
        orElse: () => NewsfeedCategories(),
      );
      selectedCategoryId = match.id;
      print("********selected Id $selectedCategoryId");
    } else {
      selectedCategoryId = null;
    }

    notifyListeners();
  }

  Future<void> setSelectedCourseCategoryName(String? id) async {
    selectedCategoryId = id;

    if (id != null && newsFeedCategoriesData?.newsfeedCategories != null) {
      final match = newsFeedCategoriesData!.newsfeedCategories!.firstWhere(
        (category) => category.id == id,
        orElse: () => NewsfeedCategories(),
      );
      selectedCategory = match.categoryName;
      print("********selected Id $selectedCategory");
    } else {
      selectedCategory = null;
    }

    notifyListeners();
  }

  /*********************Update & Delete Community */

  String editNewsFeedId = "";
  void setEditNewsFeedId(String value) {
    editNewsFeedId = value;
    notifyListeners();
  }

  Future<void> updateNewsFeedCommunity(BuildContext context) async {
    print("**************edit news feed id calling");
    Loaders.circularShowLoader(context);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);

    uploadedFiles.clear();

    for (var element in selectedFiles) {
      var value = await _http.uploadImage(element.path);
      print("resp from upload $value");
      if (value != null) {
        uploadedFiles.add(value);
      }
    }

    if (isEditNewsFeed == true) {
      uploadedFiles.addAll(existingImages);
    }

    final Map<String, dynamic> fields = {
      "description": descriptionController.text,
      "category_type": selectedCategoryId,
      "video_url": videoLinkController.text,
      "post_image": uploadedFiles,
      "web_url": websiteLinkController.text,
      "user_role": type,
      "user_id": userId,
      "status": "PUBLISHED",
      "feed_type": "NEWSFEED",
      "community_id": (type == UserRole.professional.value) ? profCommunityId : communityId,
    };

    if (type == UserRole.professional.value) {
      fields["dental_professional_id"] = userId;
    } else {
      fields["dental_supplier_id"] = userId;
    }
    final variables = {
      "id": editNewsFeedId,
      "fields": fields,
    };

    print("***************************variavles $variables");

    final res = await repo.updateNewsFeedCommunity(variables);
    if (res != null) {
      await getAllNewsFeeds(context);
      //await getAllStatusCounts();
      Loaders.circularHideLoader(context);
      scaffoldMessenger("News Feed Updated Successfully");
      navigationService.goBack();
    }

    notifyListeners();
  }

  Future<void> deleteNewsFeedCommunity(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};

    print("***************************variavles $variables");

    final res = await repo.deleteNewsFeedCommunity(variables);
    if (res != null) {
      await getAllNewsFeeds(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger("News Feed Deleted Successfully");
    }

    //getAllStatusCounts();
    notifyListeners();
  }

  BannerUrlData? bannerData;

  Future<void> getBannerUrl(BuildContext context) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final variables = {
      "value": type == UserRole.professional.value ? profCommunityId : communityId
    };
    final res = await repo.getBannerUrl(variables);
    bannerData = res;

    notifyListeners();
  }

  Future<void> leaveCommunity(BuildContext context) async {
    print("********************leave community calling");

    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "_and": [
          {
            "community_id": {"_eq": profCommunityId}
          },
          {
            "member_id": {"_eq": userId}
          }
        ]
      }
    };
    final res = await repo.leaveCommunity(variables);
    if (res != null) {
      scaffoldMessenger("Community leaved Successfully");
    }

    notifyListeners();
  }
}
