import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';

abstract class ViewProfileRepository {
  Future<DentalSuppliersByPk?> getViewProfileData(String id, String userType);
}
