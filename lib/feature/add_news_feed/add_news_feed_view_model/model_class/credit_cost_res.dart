class creditsCostsRes {
  String? eventName;
  int? creditCost;

  creditsCostsRes({this.eventName, this.creditCost});

  creditsCostsRes.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    creditCost = json['credit_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_name'] = this.eventName;
    data['credit_cost'] = this.creditCost;
    return data;
  }
}
