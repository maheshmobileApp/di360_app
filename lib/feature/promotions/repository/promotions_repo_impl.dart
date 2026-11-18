import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/promotions/model/get_promotions_res.dart';
import 'package:di360_flutter/feature/promotions/querys/get_promotions_query.dart';
import 'package:di360_flutter/feature/promotions/repository/promotions_repository.dart';

class PromotionsRepoImpl implements PromotionsRepository {
  final http = HttpService();
  @override
  Future<GetPromotionsData> getPromotions(variables) async {
    final res = await http.query(getPromotionsQuery, variables: variables);
    return GetPromotionsData.fromJson(res);
  }
}
