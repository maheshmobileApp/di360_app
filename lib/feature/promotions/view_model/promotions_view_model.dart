import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/promotions/model/get_promotions_res.dart';
import 'package:di360_flutter/feature/promotions/repository/promotions_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class PromotionsViewModel extends ChangeNotifier {
  final PromotionsRepoImpl repo = PromotionsRepoImpl();

  GetPromotionsData? getPromotionsData;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  String selectedPromotionsStatus = "ACTIVE";
  List<String> promotionsStatus = ["ACTIVE", "INACTIVE", "EXPIRED"];

  int activeCount = 0;
  int inactiveCount = 0;
  int expiredCount = 0;

  static const int _promotionsLimit = 20;
  int _promotionsOffset = 0;

  Map<String, int?> get statusPromotionCountMap => {
        'ACTIVE': activeCount,
        'INACTIVE': inactiveCount,
        'EXPIRED': expiredCount,
      };

  void changePromotionStatus(String value, BuildContext context) async {
    selectedPromotionsStatus = value;
    await getPromotions(context);
    notifyListeners();
  }

  Future<void> getPromotions(
    BuildContext context, {
    bool isLoadMore = false,
  }) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    if (isLoading || isLoadingMore) return;
    if (isLoadMore && !hasMoreData) return;

    if (!isLoadMore) {
      Loaders.circularShowLoader(context);
    }

    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      isLoading = true;
      _promotionsOffset = 0;
      hasMoreData = true;
    }
    notifyListeners();

    try {
      final variables = {
        "where": {
          "_and": [
            {
              "_and": [
                {
                  "_or": [
                    {
                      "suppliers_id": {"_eq": userId}
                    },
                    {
                      "supply_promotion_items": {
                        "supply": {
                          "dental_suppliers_id": {"_eq": userId}
                        }
                      }
                    }
                  ]
                },
                if (selectedPromotionsStatus != "EXPIRED")
                  {
                    "_or": [
                      {
                        "status": {"_neq": "EXPIRED"}
                      },
                      {
                        "status": {"_is_null": true}
                      }
                    ]
                  },
                if (selectedPromotionsStatus != "EXPIRED")
                  {
                    "is_active": {
                      "_eq":
                          selectedPromotionsStatus == "INACTIVE" ? false : true
                    }
                  },
                if (selectedPromotionsStatus == "EXPIRED")
                  {
                    "status": {"_eq": "EXPIRED"}
                  }
              ]
            },
            {}
          ]
        },
        "active": {
          "_and": [
            {
              "_or": [
                {
                  "suppliers_id": {"_eq": userId}
                },
                {
                  "supply_promotion_items": {
                    "supply": {
                      "dental_suppliers_id": {"_eq": userId}
                    }
                  }
                }
              ]
            },
            {
              "_or": [
                {
                  "status": {"_neq": "EXPIRED"}
                },
                {
                  "status": {"_is_null": true}
                }
              ]
            },
            {
              "is_active": {"_eq": true}
            }
          ]
        },
        "inactive": {
          "_and": [
            {
              "_or": [
                {
                  "suppliers_id": {"_eq": userId}
                },
                {
                  "supply_promotion_items": {
                    "supply": {
                      "dental_suppliers_id": {"_eq": userId}
                    }
                  }
                }
              ]
            },
            {
              "_or": [
                {
                  "status": {"_neq": "EXPIRED"}
                },
                {
                  "status": {"_is_null": true}
                }
              ]
            },
            {
              "is_active": {"_eq": false}
            }
          ]
        },
        "expired": {
          "_and": [
            {
              "_or": [
                {
                  "suppliers_id": {"_eq": userId}
                },
                {
                  "supply_promotion_items": {
                    "supply": {
                      "dental_suppliers_id": {"_eq": userId}
                    }
                  }
                }
              ]
            },
            {
              "status": {"_eq": "EXPIRED"}
            }
          ]
        },
        "limit": _promotionsLimit,
        "offset": _promotionsOffset
      };
      final res = await repo.getPromotions(variables);
      
      final newPromotions = res.supplyPromotions ?? [];

      if (isLoadMore) {
        final existingOrders = getPromotionsData?.supplyPromotions ?? [];
        getPromotionsData = GetPromotionsData(
          supplyPromotions: [...existingOrders, ...newPromotions],
        );
      } else {
        getPromotionsData = res;
      }

      _promotionsOffset += newPromotions.length;
      hasMoreData = newPromotions.length == _promotionsLimit;
      
      activeCount = getPromotionsData?.active?.aggregate?.count ?? 0;
      inactiveCount = getPromotionsData?.inactive?.aggregate?.count ?? 0;
      expiredCount = getPromotionsData?.expired?.aggregate?.count ?? 0;
    } finally {
      isLoading = false;
      isLoadingMore = false;
      if (!isLoadMore) {
        Loaders.circularHideLoader(context);
      }
      notifyListeners();
    }
  }
}


