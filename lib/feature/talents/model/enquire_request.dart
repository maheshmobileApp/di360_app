class EnquiryRequest {
  final String enquiryDescription;
  final String talentId;
  final String enquirySenderId;
  final String enquirySenderType;
  final String enquiryReceiverId;
  final String enquiryReceiverType;

  EnquiryRequest({
    required this.enquiryDescription,
    required this.talentId,
    required this.enquirySenderId,
    required this.enquirySenderType,
    required this.enquiryReceiverId,
    required this.enquiryReceiverType,
  });

  factory EnquiryRequest.fromJson(Map<String, dynamic> json) {
    return EnquiryRequest(
      enquiryDescription: json['enquiry_description'],
      talentId: json['talent_id'],
      enquirySenderId: json['enq_sender_id'],
      enquirySenderType: json['enq_sender_type'],
      enquiryReceiverId: json['enq_receiver_id'],
      enquiryReceiverType: json['enq_receiver_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enquiry_description': enquiryDescription,
      'talent_id': talentId,
      'enq_sender_id': enquirySenderId,
      'enq_sender_type': enquirySenderType,
      'enq_receiver_id': enquiryReceiverId,
      'enq_receiver_type': enquiryReceiverType, 
    };
  }
}
