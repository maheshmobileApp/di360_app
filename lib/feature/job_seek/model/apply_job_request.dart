import 'package:di360_flutter/feature/job_seek/model/attachment.dart';

class ApplyJobRequest {
  final String jobId;
  final String dentalProfessionalId;
  final String message;
  final List<Attachment> attachments;

  ApplyJobRequest({
    required this.jobId,
    required this.dentalProfessionalId,
    required this.message,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'dental_professional_id': dentalProfessionalId,
      'message': message,
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }

  factory ApplyJobRequest.fromJson(Map<String, dynamic> json) {
    return ApplyJobRequest(
      jobId: json['job_id'] ?? '',
      dentalProfessionalId: json['dental_professional_id'] ?? '',
      message: json['message'] ?? '',
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((attachment) =>
                  Attachment.fromJson(attachment as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

