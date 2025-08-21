import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_listings/model/get_job_applicants_count_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_status_count_model.dart';
import 'package:di360_flutter/feature/job_listings/quary/delete_job_listing_quary.dart';
import 'package:di360_flutter/feature/job_listings/quary/get_job_applicants_quary.dart';
import 'package:di360_flutter/feature/job_listings/quary/get_job_listing_quary.dart';
import 'package:di360_flutter/feature/job_listings/quary/job_status_count_quary.dart';
import 'package:di360_flutter/feature/job_listings/quary/update_joblisting_status_quary.dart';
import 'package:di360_flutter/feature/job_listings/repository/job_listing_repository.dart';


class JobListingRepoImpl extends JobListingRepository {
  final HttpService http = HttpService();

  @override
  Future<List<JobsListingDetails>?> getMyJobListing(
      List<String>? listingStatus) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final andList = <Map<String, dynamic>>[
      {
        "status": {
          "_in": listingStatus?.isEmpty == true
              ? ["APPROVE", "PENDING", "INACTIVE", "EXPIRED", "REJECT", "DRAFT"]
              : listingStatus
        }
      },
    ];
    if (type == "SUPPLIER") {
      andList.add({
        "dental_supplier_id": {"_eq": userId}
      });
    }
    if (type == "PRACTICE") {
      andList.add({
        "dental_practice_id": {"_eq": userId}
      });
    }

    final listingData =
        await http.query(getJobListingQuary, variables: {"andList": andList});
    final result = JobListing.fromJson(listingData);
    return result.jobs ?? [];
  }


  @override
  Future<dynamic> removeJobListing(String? id) async {
    final jobListingData = await http.mutation(deleteJobListing, {"id": id});
    return jobListingData;
  }

  @override
  Future<dynamic> updateJobListing(String? id, String status) async {
    final jobListingStatusData = await http
        .mutation(updateJobListingStatus, {"id": id, "status": status});
    return jobListingStatusData;
  }

  @override
  Future<JobStatusCountData> jobListingStatusCount() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final Map<String, dynamic> variables = {};

    if (type == "SUPPLIER") {
      variables["supplierId"] = userId;
    } 
    if (type == "PRACTICE") {
      variables["dental_practice_id"] = userId;
    }
    final data = await http.query(getJobStatusCount, variables: variables);
    final result = JobStatusCountData.fromJson(data);
    print(result);
    return result;
  }

@override
Future<List<JobApplicants>?>getJobApplicants(
    List<String>?  listingStatusforapplicants, String jobId) async {
  final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
  final type = await LocalStorage.getStringVal(LocalStorageConst.type);

  final andList = <Map<String, dynamic>>[
    {
      "status": {
        "_in": { listingStatusforapplicants?.isEmpty==true
            ? ["APPLIED", "INTERVIEWS", "ACCEPTED", "REJECT", "SHORTLISTED"]
            :  listingStatusforapplicants
      }
      }
    },
  ];
  if (type == "JOBID") {
    andList.add({"job_id": {"_eq": userId}});
  }
  final lisingdataforapplicants= await http.query(
    getJobApplicantsQuary,
    variables: {"andList": andList},
  );
  final result = JobApplicantsData.fromJson(lisingdataforapplicants);
  return result. jobApplicants ?? [];
}

@override
Future<GetJobApllicantsCountData> getJobApplicantsCount(String jobId) async {
  final Map<String, dynamic> variables = {
    "job_id": jobId,
  };

  final data = await http.query(getJobStatusCount, variables: variables);
  final result = GetJobApllicantsCountResp.fromJson(data);
  return result.data!; 
}

}


