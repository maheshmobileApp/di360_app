import 'package:di360_flutter/feature/talents/model/talents_model.dart';

class TalentListingtCountResponse {
  TalentListingtCountData? data;

  TalentListingtCountResponse({this.data});

  factory TalentListingtCountResponse.fromJson(Map<String, dynamic> json) {
    return TalentListingtCountResponse(
      data: TalentListingtCountData.fromJson(json['data'] ?? json),
    );
  }

  Map<String, dynamic> toJson() => {'data': data?.toJson()};
}

class TalentListingtCountData {
  List<TalentEnquiries>? talentEnquiries;
  Total? total;
  Total? pending;
  Total? approved;
  Total? expired;
  Total? draft;
  Total? rejected;

  TalentListingtCountData({
    this.talentEnquiries,
    this.total,
    this.pending,
    this.approved,
    this.expired,
    this.draft,
    this.rejected,
  });

  factory TalentListingtCountData.fromJson(Map<String, dynamic> json) {
    return TalentListingtCountData(
      talentEnquiries: (json['talent_enquiries'] as List?)
          ?.map((e) => TalentEnquiries.fromJson(e))
          .toList(),
      total: json['total'] != null ? Total.fromJson(json['total']) : null,
      pending: json['pending'] != null ? Total.fromJson(json['pending']) : null,
      approved:
          json['approved'] != null ? Total.fromJson(json['approved']) : null,
      expired:
          json['expired'] != null ? Total.fromJson(json['expired']) : null,
      draft: json['draft'] != null ? Total.fromJson(json['draft']) : null,
      rejected:
          json['rejected'] != null ? Total.fromJson(json['rejected']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'talent_enquiries':
            talentEnquiries?.map((e) => e.toJson()).toList() ?? [],
        'total': total?.toJson(),
        'pending': pending?.toJson(),
        'approved': approved?.toJson(),
        'expired': expired?.toJson(),
        'draft': draft?.toJson(),
        'rejected': rejected?.toJson(),
      };
}

class TalentEnquiries {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? enquiryDescription;
  String? enquiryFrom;
  JobProfile? jobProfiles;

  TalentEnquiries({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.enquiryDescription,
    this.enquiryFrom,
    this.jobProfiles,
  });

  factory TalentEnquiries.fromJson(Map<String, dynamic> json) {
    return TalentEnquiries(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      enquiryDescription: json['enquiry_description'],
      enquiryFrom: json['enquiry_from'],
      jobProfiles: json['job_profiles'] != null
          ? JobProfile.fromJson(json['job_profiles'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'enquiry_description': enquiryDescription,
        'enquiry_from': enquiryFrom,
        'job_profiles': jobProfiles?.toJson(),
      };
}


class Total {
  Aggregate? aggregate;

  Total({this.aggregate});

  factory Total.fromJson(Map<String, dynamic> json) =>
      Total(aggregate: json['aggregate'] != null ? Aggregate.fromJson(json['aggregate']) : null);

  Map<String, dynamic> toJson() => {'aggregate': aggregate?.toJson()};
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  factory Aggregate.fromJson(Map<String, dynamic> json) => Aggregate(count: json['count']);

  Map<String, dynamic> toJson() => {'count': count};
}
