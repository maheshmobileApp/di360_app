import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_respo.dart';
import 'package:di360_flutter/feature/enquiries/quary/enquiries_quary.dart';

class EnquiriesRespoImpo{
  final HttpService http = HttpService();

  Future<EnquiriesRespo?> fetchEnquiries({
    required String dentalProfessionalId,
  }) async {
    try {
      final variables = {
        "dental_professional_id": dentalProfessionalId,
      };

      final raw = await http.query(enquiriesJobQuery, variables: variables);

      return EnquiriesRespo.fromJson(raw);
    } catch (e, stack) {
      print("Error fetching applied jobs: $e");
      print(stack);
      return null;
    }
  }
}
