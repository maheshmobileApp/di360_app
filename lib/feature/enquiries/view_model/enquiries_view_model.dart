import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/model/get_enquiries_messages_res.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repo_impl.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listing_applicants_messge_respo.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class EnquiriesViewModel extends ChangeNotifier {
  final EnquiriesRepoImpl repo = EnquiriesRepoImpl();
  EnquiriesListResData? enquiriesListData;
  ApplicantEnquiryData? applicantEnquiriesListData;

  Future<EnquiriesListResData?> getMyEnquiryJobData(
      BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getMyEnquiryJobData(userId);
    if (res != null) {
      enquiriesListData = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }

  Future<ApplicantEnquiryData?> getApplicantEnquiryData(
      BuildContext context, String jobId) async {
    print("**********calling getApplicantEnquiryData**********");
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getApplicantEnquiryData(userId, jobId);
    if (res.jobEnquiries != null) {
      applicantEnquiriesListData = res;
      print(
          "**********getApplicantEnquiryData${res.jobEnquiries?.first.enquiryDescription}**********");
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }
  /******************Enquiry Messages****************/

  List<JobApplicantMessages> messages = [];
  bool isLoading = false;
  final TextEditingController messageController = TextEditingController();
  bool editMessage = false;
  String? errorMessage;

  String newmessage = "";
  String editMessageId = "";

  void setEditMessage(bool value) {
    editMessage = value;
    notifyListeners();
  }

  void setEditMessageDetails(String id, String message) {
    editMessageId = id;
    newmessage = message;
    notifyListeners();
  }

  Future<void> fetchEnquiriesMessages(String jobId) async {
    final variables = {
        "job_enquiry_id": {"_eq": jobId}
      };
    try {
      isLoading = true;

      final res = await repo.fetchEnquiriesMessages(variables);
      if (res.jobApplicantMessages != null) {
        messages = res.jobApplicantMessages??[];
        print("******************messages fetched ${messages}");
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
/*
  Future<void> updateApplicantMessage(
      BuildContext context, String applicantId) async {
    try {
      isLoading = true;

      final res = await repo.updateApplicantMessage(
          editMessageId, messageController.text);
      if (res != null) {
        setEditMessage(false);
        await fetchApplicantMessages(applicantId);
        scaffoldMessenger("Message updated successfully");
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendApplicantMessage(BuildContext context, String applicantId,
      String message, String? typeName) async {
    if (message.isEmpty) {
      scaffoldMessenger("Message cannot be empty");
      return;
    }

    try {
      Loaders.circularShowLoader(context);
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

      final res = await repo.sendApplicantMessage({
        "job_applicant_id": applicantId,
        "message": message,
        "message_from": userId,
      }, typeName ?? "");

      if (res != null) {
        scaffoldMessenger("Message sent successfully");
        messageController.clear();
        /*messages.add(
          JobApplicantMessage(
            id: res, // backend ID
            jobApplicantId: applicantId,
            message: message,
            messageFrom: "me", // mark current user
            createdAt: DateTime.now().toIso8601String(),
          ),
        );*/
        fetchApplicantMessages(applicantId);
      } else {
        scaffoldMessenger("Failed to send message");
      }
    } catch (e) {
      scaffoldMessenger("Error: $e");
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> deleteapplicantMessage(BuildContext context, String Id,
      String applicantId, bool deletedStatus) async {
    print("******************deleteapplicantMessage called");
    try {
      isLoading = true;

      final res = await repo.deleteApplicantMessage(Id, deletedStatus);
      print("res $res");
      await fetchApplicantMessages(applicantId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }*/
}
