import '../../talents/model/job_profile.dart';
class TalentEnquiryListResponse {
  final List<TalentEnquiry> talentEnquiries;

  TalentEnquiryListResponse({required this.talentEnquiries});

  factory TalentEnquiryListResponse.fromJson(Map<String, dynamic> json) {

    final list = json['data']?['talent_enquiries'] as List<dynamic>? ?? [];
    return TalentEnquiryListResponse(
      talentEnquiries: list.map((e) => TalentEnquiry.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': {
          'talent_enquiries': talentEnquiries.map((e) => e.toJson()).toList(),
        }
      };
}

class TalentEnquiry {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? talentId;
  final String? enquiryDescription;
  final String? enquiryFrom;
  final JobProfile? jobProfile;

  TalentEnquiry({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.talentId,
    this.enquiryDescription,
    this.enquiryFrom,
    this.jobProfile,
  });

  factory TalentEnquiry.fromJson(Map<String, dynamic> json) => TalentEnquiry(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        talentId: json['talent_id'],
        enquiryDescription: json['enquiry_description'],
        enquiryFrom: json['enquiry_from'],
        jobProfile: json['job_profiles'] != null
            ? JobProfile.fromJson(json['job_profiles'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'talent_id': talentId,
        'enquiry_description': enquiryDescription,
        'enquiry_from': enquiryFrom,
        'job_profiles': jobProfile?.toJson(),
      };
}

