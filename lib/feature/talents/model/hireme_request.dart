import 'package:di360_flutter/feature/job_seek/model/attachment.dart';

class HireMeRequest {
  final String? dentalSupplierId;
  final String dentalProfessionalId;
  final String message;
  final List<Attachment> attachments;

  HireMeRequest({
    this.dentalSupplierId,
    required this.dentalProfessionalId,
    required this.message,
    required this.attachments,
  });

  factory HireMeRequest.fromJson(Map<String, dynamic> json) {
    return HireMeRequest(
      dentalSupplierId: json['dental_supplier_id'],
      dentalProfessionalId: json['dental_professional_id'],
      message: json['message'],
      attachments: (json['attachments'] as List<dynamic>)
          .map((attachment) => Attachment.fromJson(attachment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dental_supplier_id': dentalSupplierId,
      'dental_professional_id': dentalProfessionalId,
      'message': message,
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }

}
  
