import 'package:di360_flutter/feature/banners/model/get_banners.dart';

class GetDisableMonths {
  final DisableMonthsData? data;

  GetDisableMonths({this.data});

  factory GetDisableMonths.fromJson(Map<String, dynamic> json) {
    return GetDisableMonths(
      data: json['data'] != null ? DisableMonthsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class DisableMonthsData {
  final List<Banners> banners;

  DisableMonthsData({required this.banners});

  factory DisableMonthsData.fromJson(Map<String, dynamic> json) {
    return DisableMonthsData(
      banners: (json['banners'] as List<dynamic>?)
              ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banners': banners.map((e) => e.toJson()).toList(),
    };
  }
}