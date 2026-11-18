import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_details_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_res.dart';

abstract class SuppliesEnquiriesRepository {
  Future<SuppliesEnquiriesData> getSuppliesEnquiries(dynamic variables);
  Future<SuppliesEnquiriesDetailsData> getSuppliesEnquiriesDetails(
      dynamic variables);
}
