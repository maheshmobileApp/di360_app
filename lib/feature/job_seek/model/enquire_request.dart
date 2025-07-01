class EnquireRequest {
  final String enquiryDescription;
  final String jobId;
  final String enquiryUserId;

  EnquireRequest({
    required this.enquiryDescription,
    required this.jobId,
    required this.enquiryUserId,
  });

  Map<String, dynamic> toJson() {
    return {
      "enquiry_description": enquiryDescription,
      "job_id": jobId,
      "enquiry_userid": enquiryUserId,
    };
  }
 
}
