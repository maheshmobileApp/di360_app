import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_details_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/model/supplies_enquiries_res.dart';
import 'package:di360_flutter/feature/supplies_enquiries/querys/supplies_enquiries_query.dart';
import 'package:di360_flutter/feature/supplies_enquiries/querys/supplies_enquiry_detail_view.dart';
import 'package:di360_flutter/feature/supplies_enquiries/repository/supplies_enquiries_repository.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';

class SuppliesEnquiriesRepoImpl implements SuppliesEnquiriesRepository {
  final http = HttpService();
  @override
  Future<SuppliesEnquiriesData> getSuppliesEnquiries(variables) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await http.query(
        type == UserRole.supplier.value
            ? suppliesEnquiriesQuery
            : getSuppliesEnquiriesTwoQuery,
        variables: variables);
    return SuppliesEnquiriesData.fromJson(res);
  }

  @override
  Future<SuppliesEnquiriesDetailsData> getSuppliesEnquiriesDetails(
      variables) async {
    final res =
        await http.query(suppliesEnquiryDetailViewQuery, variables: variables);
    return SuppliesEnquiriesDetailsData.fromJson(res);
  }
}
