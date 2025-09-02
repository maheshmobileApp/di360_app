import 'package:di360_flutter/feature/enquiries/model/enquiries_respo.dart';

abstract class EnquiriesRepository {
  Future<EnquiriesRespo?> fetchEnquiries({
    required String dentalProfessionalId,
  });
}
