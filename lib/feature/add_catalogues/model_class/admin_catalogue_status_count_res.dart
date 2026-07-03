import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_count_res.dart';

class AdminCatalogueStatusCountRes {
  CatalogueStatusCountData? data;

  AdminCatalogueStatusCountRes({this.data});

  AdminCatalogueStatusCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CatalogueStatusCountData.fromJson(json['data'])
        : null;
  }
}

class CatalogueStatusCountData {
  ApprovalPending? approvalPending;
  Approved? approved;
  Rejected? rejected;
  Expired? expired;
  Inactive? inactive;
  All? all;

  CatalogueStatusCountData(
      {this.approvalPending,
      this.approved,
      this.rejected,
      this.expired,
      this.inactive,
      this.all});

  CatalogueStatusCountData.fromJson(Map<String, dynamic> json) {
    approvalPending = json['approval_pending'] != null
        ? new ApprovalPending.fromJson(json['approval_pending'])
        : null;
    approved = json['approved'] != null
        ? new Approved.fromJson(json['approved'])
        : null;
    rejected = json['rejected'] != null
        ? new Rejected.fromJson(json['rejected'])
        : null;
    expired =
        json['expired'] != null ? new Expired.fromJson(json['expired']) : null;
    inactive = json['inactive'] != null
        ? new Inactive.fromJson(json['inactive'])
        : null;
    all = json['all'] != null ? new All.fromJson(json['all']) : null;
  }
}
