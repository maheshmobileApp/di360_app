class EnquiryRequest {
  final String enquiryDescription;
  final String talentId;
  final String enquiryFrom;

  EnquiryRequest({
    required this.enquiryDescription,
    required this.talentId,
    required this.enquiryFrom,
  });

  factory EnquiryRequest.fromJson(Map<String, dynamic> json) {
    return EnquiryRequest(
      enquiryDescription: json['enquiry_description'],
      talentId: json['talent_id'],
      enquiryFrom: json['enquiry_from'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enquiry_description': enquiryDescription,
      'talent_id': talentId,
      'enquiry_from': enquiryFrom,
    };
  }


}
