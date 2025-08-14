
import 'package:di360_flutter/feature/talent_listing/model/talent_profile_response.dart';

abstract class TalentListingRepository {
  Future<List<TalentProfile>> getTalentListings();
}
