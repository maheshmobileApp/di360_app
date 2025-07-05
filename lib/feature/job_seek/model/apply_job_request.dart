import 'package:di360_flutter/feature/job_seek/model/attachment.dart';

class ApplyJobRequest {
   String? id; // Added missing id field
  String jobId;
  final String dentalProfessionalId;
  final String message;
  Attachment attachments; // Changed from List<Attachment> to single Attachment
  final String? firstName; // Added missing firstName field

  ApplyJobRequest({
    this.id,
    required this.jobId,
    required this.dentalProfessionalId,
    required this.message,
    required this.attachments,
    this.firstName,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'job_id': jobId,
      'dental_professional_id': dentalProfessionalId,
      'message': message,
      'attachments': attachments.toJson(),
    };

    if (id != null) json['id'] = id!;
    if (firstName != null) json['first_name'] = firstName!;

    return json;
  }

  factory ApplyJobRequest.fromJson(Map<String, dynamic> json) {
    return ApplyJobRequest(
      id: json['id'],
      jobId: json['job_id'] ?? '',
      dentalProfessionalId: json['dental_professional_id'] ?? '',
      message: json['message'] ?? '',
      attachments:
          Attachment.fromJson(json['attachments'] as Map<String, dynamic>),
      firstName: json['first_name'],
    );
  }
}
