
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_news_feed/model_class/get_categories.dart';
import 'package:di360_flutter/feature/add_news_feed/update_news_feed.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsFeedViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();

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
    const String query = '''
    query getAllNewsfeedCategories {
  newsfeed_categories(
    where: {community_id: {_is_null: true}}
    order_by: {created_at: desc}
  ) {
    id
    category_name
    created_at
    updated_at
    created_by
    created_by_user_id
  }
}
  ''';

    try {
      final response = await _http.query(query);
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
          uploadedFiles.add(value['data'] ?? value);
        }
      }

      final res = await _http.mutation(addNewsFeed, {
        "object": {
          "description": desController.text,
          "category_type": selectedCategory?.id,
          "video_url": videoController.text,
          "post_image": uploadedFiles,
          "web_url": websiteController.text,
          "user_role": type,
          "user_id": userId,
          "status": "PENDING",
          "dental_practice_id": type == UserRole.practice.value ? userId : null,
          "dental_supplier_id": type == UserRole.supplier.value ? userId : null,
          "dental_professional_id":
              type == UserRole.professional.value ? userId : null,
          "dental_admin_id": type == UserRole.admin.value ? userId : null,
          "feed_type": "NEWSFEED",
        }
      });

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
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    Loaders.circularShowLoader(context);
    try {
      uploadedFiles.clear();
      for (var element in selectedFiles) {
        var value = await _http.uploadImage(element.path);
        if (value != null) {
          uploadedFiles.add(value['data'] ?? value);
        }
      }

      if (isEditNewsFeed == true) {
        uploadedFiles.addAll(existingImages);
      }

      final res = await _http.mutation(updatedTheNewsFeedQuery, {
        "id": newsFeedId,
        "data": {
          "description": desController.text,
          "category_type": selectedCategory?.id,
          "video_url": videoController.text,
          "post_image": uploadedFiles,
          "web_url": websiteController.text,
          "user_role": type,
          "user_id": userId,
          "status": "PUBLISHED",
          "dental_practice_id": type == 'PRACTICE' ? userId : null,
          "dental_supplier_id": type == 'SUPPLIER' ? userId : null,
          "dental_professional_id": type == 'PROFESSIONAL' ? userId : null,
          "dental_admin_id": type == 'ADMIN' ? userId : null,
          "feed_type": "NEWSFEED",
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
    desController.text = newsfeeds?.description ?? '';
    editSelectCategoryAssigned(newsfeeds?.categoryType ?? '');
    notifyListeners();
  }

  editSelectCategoryAssigned(String id) {
    final category = newsfeedCategories?.firstWhere((val) => val.id == id, orElse: () => newsfeedCategories!.first);
    setSelectedCategory(id.isEmpty ? null : category);
    notifyListeners();
  }
}

const addNewsFeed = '''
    mutation insert_newsfeeds_one(\$object: newsfeeds_insert_input!) {
      insert_newsfeeds_one(object: \$object) {
        id
        __typename
      }
    }
  ''';
