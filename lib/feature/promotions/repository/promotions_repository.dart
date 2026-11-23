import 'package:di360_flutter/feature/promotions/model/get_promotions_res.dart';

abstract class PromotionsRepository {
  Future<GetPromotionsData> getPromotions(dynamic variables);
}
