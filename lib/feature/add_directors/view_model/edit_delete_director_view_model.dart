import 'package:di360_flutter/feature/add_directors/model/get_appts_res.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository_impl.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDeleteDirectorViewModel extends ChangeNotifier {
  final AddDirectorRepositoryImpl addDirectorRepositoryImpl =
      AddDirectorRepositoryImpl();

  bool showCertifiForm = false;
  bool isEditAchieve = false;
  bool isEditDocu = false;
  bool isEditOurTeam = false;
  bool isEditGallery = false;
  bool isEditFAQ = false;
  bool isEditTestimonal = false;
  bool isEditTimings = false;
  bool isEditSocialMed = false;
  List<DirectoryApptsSlots>? appointmentsList = [];

  void updateShowCertifiForm(bool val) {
    showCertifiForm = val;
    notifyListeners();
  }

  void updateIsEditAchieve(bool val) {
    isEditAchieve = val;
    notifyListeners();
  }

  void updateIsEditDocu(bool val) {
    isEditDocu = val;
    notifyListeners();
  }

  void updateIsEditOurTeam(bool val) {
    isEditOurTeam = val;
    notifyListeners();
  }

  void updateIsEditGallery(bool val) {
    isEditGallery = val;
    notifyListeners();
  }

  void updateIsEditFAQ(bool val) {
    isEditFAQ = val;
    notifyListeners();
  }

  void updateIsEditTestimonials(bool val) {
    isEditTestimonal = val;
    notifyListeners();
  }

  void updateIsEditTimings(bool val) {
    isEditTimings = val;
    notifyListeners();
  }

  void updateIsEditSocialMed(bool val) {
    isEditSocialMed = val;
    notifyListeners();
  }

  Future<void> updateTheServices(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
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
    final addDirectorVM = context.read<AddDirectoryViewModel>();
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
    final addDirectorVM = context.read<AddDirectoryViewModel>();
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
    final addDirectorVM = context.read<AddDirectoryViewModel>();
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
    final addDirectorVM = context.read<AddDirectoryViewModel>();
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

  Future<void> deleteTheAchieve(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteAchieve({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete achievement successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheDocu(
      BuildContext context, String id, dynamic img) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    dynamic attachments;
    if (addDirectorVM.documentFile != null) {
      attachments = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.documentFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateDocu({
      "id": id,
      "updateDocs": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "attachment": attachments ?? img,
        "name": addDirectorVM.documentNameController.text
      }
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Update document successfully');
      updateIsEditDocu(false);
      addDirectorVM.documentNameController.clear();
      addDirectorVM.documentFile = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheDocument(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteDocu({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete document successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheOurTeam(
      BuildContext context, String id, dynamic img) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    dynamic attachments;
    if (addDirectorVM.teamMemberFile != null) {
      attachments = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.teamMemberFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateOurTeam({
      "ourTeamObj": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "name": addDirectorVM.teamNameCntr.text,
        "specialization": addDirectorVM.teamDesignationCntr.text,
        "image": attachments ?? img,
        "email": addDirectorVM.teamEmailIDCntr.text,
        "phone": addDirectorVM.teamNumberCntr.text,
        "location": addDirectorVM.teamLocationCntr.text,
        "show_in_our_team": addDirectorVM.ourTeamShowVal ? "yes" : 'No',
        "show_in_appointments": addDirectorVM.appointmentShowVal ? "yes" : 'No'
      },
      "id": id
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated our team successfully');
      updateIsEditOurTeam(false);
      addDirectorVM.teamDesignationCntr.clear();
      addDirectorVM.teamEmailIDCntr.clear();
      addDirectorVM.teamLocationCntr.clear();
      addDirectorVM.teamNameCntr.clear();
      addDirectorVM.teamNumberCntr.clear();
      addDirectorVM.teamMemberFile = null;
      addDirectorVM.ourTeamShowVal = false;
      addDirectorVM.appointmentShowVal = false;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheOurTeam(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteOurTeam({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete our team successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheGallery(
      BuildContext context, String id, dynamic img) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    dynamic attachments;
    if (addDirectorVM.galleryFile != null) {
      attachments = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.galleryFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateGallery({
      "id": id,
      "updateImagesObj": {
        "image": [attachments ?? img]
      }
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated gallery successfully');
      updateIsEditGallery(false);
      addDirectorVM.galleryFile = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheFAQ(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.updateFAQ({
      "faqsObj": {
        "question": addDirectorVM.questionCntr.text,
        "answer": addDirectorVM.answerCntr.text,
        "directory_id": addDirectorVM.getBasicInfoData.first.id
      },
      "id": id
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated FAQ successfully');
      updateIsEditFAQ(false);
      addDirectorVM.questionCntr.clear();
      addDirectorVM.answerCntr.clear();
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheFAQ(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteFaq({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete faq successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheTestimonial(
      BuildContext context, String id, dynamic img, dynamic msgImg) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    dynamic imageAttach;
    if (addDirectorVM.testimonialsFile != null) {
      imageAttach = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.testimonialsFile?.path);
    }
    dynamic msgPicAttach;
    if (addDirectorVM.testimonialsPicFile != null) {
      msgPicAttach = await addDirectorRepositoryImpl.http
          .uploadImage(addDirectorVM.testimonialsPicFile?.path);
    }
    final res = await addDirectorRepositoryImpl.updateTestimonial({
      "id": id,
      "updateTestimonials": {
        "name": addDirectorVM.testiNameCntr.text,
        "role": addDirectorVM.roleCntr.text,
        "message": addDirectorVM.messageCntr.text,
        "profile_image": imageAttach ?? img,
        "msg_pic": msgPicAttach ?? msgImg,
        "directory_id": addDirectorVM.getBasicInfoData.first.id
      }
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated testimonial successfully');
      updateIsEditTestimonials(false);
      addDirectorVM.testiNameCntr.clear();
      addDirectorVM.roleCntr.clear();
      addDirectorVM.messageCntr.clear();
      addDirectorVM.testimonialsFile = null;
      addDirectorVM.testimonialsPicFile = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheTestimonial(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteTestimonial({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete testimonial successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheTimings(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.updateTimings({
      "locationObj": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "week_name": addDirectorVM.selectWeekCntr.text,
        "clinic_time":
            "${addDirectorVM.serviceStartTimeCntr.text} - ${addDirectorVM.serviceEndTimeCntr.text}",
        "status": "TIME"
      },
      "id": id
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated Timings successfully');
      updateIsEditTimings(false);
      addDirectorVM.selectWeekCntr.clear();
      addDirectorVM.serviceStartTimeCntr.clear();
      addDirectorVM.serviceEndTimeCntr.clear();
      addDirectorVM.selectedDays = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteTheTimimngs(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteTimings({"id": id});
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Delete timings successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> updateTheSocialurl(BuildContext context, String id) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.updateSocailUrl({
      "locationObj": {
        "media_name": addDirectorVM.selectedAccount,
        "media_link": addDirectorVM.socialAccountsurlCntr.text,
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "status": "SOCIAL"
      },
      "id": id
    });
    if (res != null) {
      addDirectorVM.getDirectories();
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Updated social successfully');
      updateIsEditTimings(false);
      addDirectorVM.socialAccountsurlCntr.clear();
      addDirectorVM.selectedAccount = null;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> addAppointment(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    final res = await addDirectorRepositoryImpl.addAppointment({
      "apptData": {
        "directory_id": addDirectorVM.getBasicInfoData.first.id,
        "directory_service_id": [],
        "day_wise_timeslots": addDirectorVM.dayWiseTimeSlots,
        "duration_in_minites": addDirectorVM.serviceTimemInCntr.text,
        "service_name": addDirectorVM.selectedServiceList,
        "serviceMember": addDirectorVM.selectedTeamMemberList,
        "weekdays": addDirectorVM.selectedDaysList
      }
    });
    if (res != null) {
      getAppointments(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Appointment added successfully');
      clearAppointmentFields(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> deleteAppointment(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl.deleteAppointment({"id": id});
    if (res != null) {
      getAppointments(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger('Appointment deleted successfully');
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  clearAppointmentFields(BuildContext context) {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    addDirectorVM.serviceTimemInCntr.clear();
    addDirectorVM.selectedAccount = null;
    addDirectorVM.clearDaysList();
    addDirectorVM.clearServicesList();
    addDirectorVM.clearTeamMemberList();
    notifyListeners();
  }

  Future<void> getAppointments(BuildContext context) async {
    final addDirectorVM = context.read<AddDirectoryViewModel>();
    Loaders.circularShowLoader(context);
    final res = await addDirectorRepositoryImpl
        .getAppts(addDirectorVM.getBasicInfoData.first.id ?? '');
    if (res != null) {
      appointmentsList = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
