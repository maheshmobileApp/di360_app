import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/model/get_enquiries_messages_res.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repo_impl.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class EnquiriesViewModel extends ChangeNotifier {
  final EnquiriesRepoImpl repo = EnquiriesRepoImpl();
  EnquiriesListResData? enquiriesListData;
  ApplicantEnquiryData? applicantEnquiriesListData;
  List<Jobs>? jobEnquiryDetails;

  Future<EnquiriesListResData?> getMyEnquiryJobData(
      BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "limit": 10,
      "offset": 0,
      "where": {
        "enq_sender_id": {"_eq": userId}
      }
    };
    final res = await repo.getMyEnquiryJobData(variables);
    enquiriesListData = res;
    Loaders.circularHideLoader(context);
    notifyListeners();
    return res;
  }
  
  Future<ApplicantEnquiryData?> getApplicantEnquiryData(
      BuildContext context, String jobId) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getApplicantEnquiryData(userId, jobId);
    if (res.jobEnquiries != null) {
      applicantEnquiriesListData = res;
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
      "where": {
        "_and": [
          {
            "_or": [
              {
                "job_enquiry_id": {"_eq": jobId}
              }
            ]
          }
        ]
      },
      "limit": 20
    };
    print("****************************variables $variables");
    try {
      isLoading = true;

      final res = await repo.fetchEnquiriesMessages(variables);
      if (res.jobApplicantMessages != null) {
        messages = res.jobApplicantMessages ?? [];
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getJobEnquiryDetails(
      BuildContext context, String jobEnquiryId) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"id": jobEnquiryId, "loginID": userId};
/*{
    "id": "d5359067-f2b2-4dfb-9f0e-6653a6a232c0",
    "loginID": "0b62fae9-cd87-4a6b-923d-31d507e037c2"
}*/
    print("variables $variables");

    final res = await repo.getJobEnquiryDetails(variables);
    if (res != null) {
      jobEnquiryDetails = res;
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> updateApplicantMessage(
      BuildContext context, String applicantId) async {
    final variables = {"id": editMessageId, "message": messageController.text};
    try {
      isLoading = true;
      print("***********variables $variables");

      final res = await repo.updateApplicantMessage(variables);
      if (res != null) {
        setEditMessage(false);
        await fetchEnquiriesMessages(applicantId);
        scaffoldMessenger("Message updated successfully");
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendApplicantMessage(BuildContext context, String jobId,
      String jobEnquiryId, String receiverId) async {
    if (messageController.text.isEmpty) {
      scaffoldMessenger("Message cannot be empty");
      return;
    }

    try {
      Loaders.circularShowLoader(context);
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final variables = {
        "object": {
          "message": messageController.text,
          "job_id": jobId,
          "job_enquiry_id": jobEnquiryId,
          "sender_id": userId,
          "sender_type": "PROFESSIONAL",
          "receiver_id": receiverId,
          "receiver_type": "SUPPLIER"
        }
      };

      final res = await repo.sendApplicantMessage(variables);

      if (res != null) {
        scaffoldMessenger("Message sent successfully");
        messageController.clear();
        await fetchEnquiriesMessages(jobEnquiryId);
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
    final variables = {"id": Id, "deleted_status": deletedStatus};
    try {
      isLoading = true;

      final res = await repo.deleteApplicantMessage(variables);
      print("res $res");
      await fetchEnquiriesMessages(applicantId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
