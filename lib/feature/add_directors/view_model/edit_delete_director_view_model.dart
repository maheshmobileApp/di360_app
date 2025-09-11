import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDeleteDirectorViewModel extends ChangeNotifier {
  final AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

//context.read<HomeViewModel>().getAllNewsfeeds(context);

  bool showCertifiForm = false;
  bool isEditAchieve = false;

  void updateShowCertifiForm(bool val) {
    showCertifiForm = val;
    notifyListeners();
  }

  void updateIsEditAchieve(bool val) {
    isEditAchieve = val;
    notifyListeners();
  }

  Future<void> updateTheServices(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectorViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.updateService({
      "servicesObj": {
        "name": addDirectorVM.serviceNameController.text,
        "description": addDirectorVM.serviceDescController.text,
        "show_in_appointments": addDirectorVM.serviceShowApmt,
        "directory_id": addDirectorVM.getBasicInfoData.first.id
      },
      "id": id
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Update service successfully');
      addDirectorVM.toggleService(false);
      addDirectorVM.updateIsEditService(false);
      addDirectorVM.serviceNameController.clear();
      addDirectorVM.serviceDescController.clear();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheServices(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectorViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteService({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete service successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheCertifi(
      BuildContext context, String id, dynamic img) async {
    final addDirectorVM = context.read<AddDirectorViewModel>();
    Loaders.circularShowLoader(context);
    dynamic attachments;
    if (addDirectorVM.certificateFile != null) {
      attachments = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.certificateFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateCertificate({
      "id": id,
      "updateCerti": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "attachments": attachments ?? img,
        "title": addDirectorVM.certificateNameController.text
      }
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Update certificate successfully');
      updateShowCertifiForm(false);
      addDirectorVM.certificateNameController.clear();
      addDirectorVM.certificateFile = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheCertifi(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectorViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteCertificate({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete certificate successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheAchieve(
      BuildContext context, String id, dynamic img) async {
    final addDirectorVM = context.read<AddDirectorViewModel>();
    Loaders.circularShowLoader(context);
    dynamic attachments;
    if (addDirectorVM.achievementFile != null) {
      attachments = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.achievementFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateAchieve({
      "id": id,
      "updateAch": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "attachments": attachments ?? img,
        "title": addDirectorVM.achievementNameController.text
      }
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Update achievement successfully');
      updateShowCertifiForm(false);
      addDirectorVM.achievementNameController.clear();
      addDirectorVM.achievementFile = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
