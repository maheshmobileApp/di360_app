import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_news_feed/model_class/get_categories.dart';
import 'package:di360_flutter/feature/add_news_feed/repository/add_news_feed_repo_impl.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsFeedViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final AddNewsFeedRepoImpl repo = AddNewsFeedRepoImpl();

  // AddNewsFeedViewModel() {
  //   fetchNewsfeedCategories();
  // }

  final TextEditingController videoController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  List<NewsfeedCategories>? newsfeedCategories;
  List<XFile> selectedFiles = [];
  List uploadedFiles = [];
  bool? isEditNewsFeed = false;
  String? newsFeedId;
  List existingImages = [];
  bool enableComments = true;
  String? userType;

  void setEnableComments(bool value) {
    enableComments = value;
    notifyListeners();
  }

  NewsfeedCategories? selectedCategory;

  void setSelectedCategory(NewsfeedCategories? category) {
    selectedCategory = category;
    notifyListeners();
  }

  /*Future<void> pickFiles() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedFiles.addAll(images);
      notifyListeners();
    }
  }*/

  void addFiles(List<XFile> files) {
    selectedFiles.addAll(files);
    notifyListeners();
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
    notifyListeners();
  }

  Future<void> fetchNewsfeedCategories() async {
    final professionTypeId =
        await LocalStorage.getStringVal(LocalStorageConst.professionId);
    const String query = r'''
    query getAllNewsfeedCategories($where: newsfeed_categories_bool_exp!) {
  newsfeed_categories(where: $where, order_by: {created_at: desc}) {
    id
    category_name
    created_at
    updated_at
    created_by
    created_by_user_id
    __typename
  }
}''';
    final variables = {
      "where": {
        "_and": [
          {
            "community_id": {"_is_null": true}
          },
          if (professionTypeId.isNotEmpty)
            {
              "_or": [
                {
                  "access_rules": {
                    "directory_category_id": {"_eq": professionTypeId}
                  }
                }
              ]
            }
        ]
      },
    };

    try {
      final response = await _http.query(query, variables: variables);
      if (response != null) {
        final res = CategoriesData.fromJson(response);
        newsfeedCategories = res.newsfeedCategories;
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
    notifyListeners();
  }

  addNewsFeeds(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    try {
      uploadedFiles.clear();
      print("Selected files: ${selectedFiles.length}");
      for (var element in selectedFiles) {
        print("Uploading file: ${element.path}");
        var value = await _http.uploadImage(element.path);
        if (value != null) {
          final data = value['data'] ?? value;
          uploadedFiles.add({
            "id": data['file_id'],
            "name": data['name'],
            "type": data['mime_type'],
            "url": data['url'],
          });
        }
      }

      final variables = {
        "fields": {
          "description": desController.text,
          "category_type": selectedCategory?.id,
          "video_url": videoController.text,
          "post_image": uploadedFiles,
          "web_url": websiteController.text,
          "user_role": type,
          "user_id": userId,
          "status": "PENDING",
          if (type == UserRole.practice.value) "dental_practice_id": userId,
          if (type == UserRole.supplier.value) "dental_supplier_id": userId,
          if (type == UserRole.professional.value)
            "dental_professional_id": userId,
          if (type == UserRole.admin.value) "dental_admin_id": userId,
          "feed_type": "NEWSFEED",
          "community_id": null,
          "community_type": "BOTH",
           if (type == UserRole.supplier.value) "comments_enabled": enableComments,
        }
      };

      print("***************$variables");

      final res = await repo.addNewsFeed(variables);

      if (res.isNotEmpty) {
        uploadedFiles.clear();
        Loaders.circularHideLoader(context);
        scaffoldMessenger('Newsfeed submitted successfully');
        navigationService.goBack();
        clearFeedNews();
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('$e');
    }
    notifyListeners();
  }

  updateTheNewsFeeds(BuildContext context) async {
    // final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    try {
      uploadedFiles.clear();
      for (var element in selectedFiles) {
        var value = await _http.uploadImage(element.path);
        if (value != null) {
          final data = value['data'] ?? value;
          uploadedFiles.add({
            "id": data['file_id'],
            "name": data['name'],
            "type": data['mime_type'],
            "url": data['url'],
          });
        }
      }

      if (isEditNewsFeed == true) {
        uploadedFiles.addAll(existingImages);
      }

      final res = await repo.updateNewsFeed({
        "id": newsFeedId,
        "fields": {
          "description": desController.text,
          "category_type": selectedCategory?.id,
          "video_url": videoController.text,
          "post_image": uploadedFiles,
          "web_url": websiteController.text,
          if (type == UserRole.supplier.value)  "comments_enabled": enableComments,
        }
      });

      if (res.isNotEmpty) {
        uploadedFiles.clear();
        updateTheNewsFeedObject(context, res['update_newsfeeds_by_pk']);
        Loaders.circularHideLoader(context);
        scaffoldMessenger('Newsfeed updated successfully');
        navigationService.goBack();
        clearFeedNews();
      } else {
        Loaders.circularHideLoader(context);
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      scaffoldMessenger('$e');
    }
    notifyListeners();
  }

  Future<void> updateTheNewsFeedObject(
      BuildContext context, dynamic object) async {
    final newsfeedVM = context.read<NewsFeedViewModel>();
    final feedIndex = newsfeedVM.allNewsFeedsData?.newsfeeds
        ?.indexWhere((v) => v.id == newsFeedId);
    if (feedIndex != null && feedIndex != -1) {
      newsfeedVM.allNewsFeedsData?.newsfeeds?[feedIndex] =
          Newsfeeds.fromJson(object);
    }
    newsfeedVM.notifyListeners();
    notifyListeners();
  }

  Future<void> getUserType() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    setUserType(type);
  }

  void setUserType(String type) {
    userType = type;
    notifyListeners();
    
  }

  clearFeedNews() {
    videoController.clear();
    websiteController.clear();
    desController.clear();
    selectedFiles.clear();
    existingImages.clear();
    isEditNewsFeed = false;
    selectedCategory = null;
    uploadedFiles.clear();
    notifyListeners();
  }

  void updateEditNewsVal(bool? editVal, {String? feedId}) {
    isEditNewsFeed = editVal;
    this.newsFeedId = feedId;
    notifyListeners();
  }

  void removeExistingFile(int index) {
    existingImages.removeAt(index);
    notifyListeners();
  }

  editFeedObject(Newsfeeds? newsfeeds) {
    updateEditNewsVal(true, feedId: newsfeeds?.id);
    final images = newsfeeds?.postImage ?? [];
    existingImages.clear();
    existingImages.addAll(images);
    videoController.text = newsfeeds?.videoUrl ?? '';
    websiteController.text = newsfeeds?.webUrl ?? '';
    desController.text =  htmlParser.parse(newsfeeds?.description ?? '').body?.text ?? '';
    setEnableComments(newsfeeds?.commentsEnabled ?? false);
    editSelectCategoryAssigned(newsfeeds?.categoryType ?? '');
    notifyListeners();
  }

  editSelectCategoryAssigned(String id) {
    final category = newsfeedCategories?.firstWhere((val) => val.id == id,
        orElse: () => newsfeedCategories!.first);
    setSelectedCategory(id.isEmpty ? null : category);
    notifyListeners();
  }
}
