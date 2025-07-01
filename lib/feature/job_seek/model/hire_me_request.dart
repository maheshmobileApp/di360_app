import 'package:di360_flutter/feature/job_seek/model/attachment.dart';

class HireMeRequest {
  final String? dentalSupplierId;
  final String? dentalProfessionalId;
  final String? message;
  final List<Attachment>? attachments;

  HireMeRequest({
    this.dentalSupplierId,
    this.dentalProfessionalId,
    this.message,
    this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'dental_supplier_id': dentalSupplierId,
      'dental_professional_id': dentalProfessionalId,
      'message': message,
      'attachments':
          attachments?.map((attachment) => attachment.toJson()).toList(),
    };
  }

  factory HireMeRequest.fromJson(Map<String, dynamic> json) {
    return HireMeRequest(
      dentalSupplierId: json['dental_supplier_id'],
      dentalProfessionalId: json['dental_professional_id'],
      message: json['message'],
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((attachment) => Attachment.fromJson(attachment))
              .toList()
          : null,
    );
  }

  HireMeRequest copyWith({
    String? dentalSupplierId,
    String? dentalProfessionalId,
    String? message,
    List<Attachment>? attachments,
  }) {
    return HireMeRequest(
      dentalSupplierId: dentalSupplierId ?? this.dentalSupplierId,
      dentalProfessionalId: dentalProfessionalId ?? this.dentalProfessionalId,
      message: message ?? this.message,
      attachments: attachments ?? this.attachments,
    );
  }
}
