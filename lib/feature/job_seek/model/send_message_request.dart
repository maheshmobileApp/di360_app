class SendMessageRequest {
  final String jobApplicantId;
  final String message;
  final String messageFrom;

  SendMessageRequest({
    required this.jobApplicantId,
    required this.message,
    required this.messageFrom,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_applicant_id': jobApplicantId,
      'message': message,
      'message_from': messageFrom,
    };
  }

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return SendMessageRequest(
      jobApplicantId: json['job_applicant_id'] ?? '',
      message: json['message'] ?? '',
      messageFrom: json['message_from'] ?? '',
    );
  }
}
