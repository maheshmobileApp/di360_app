class creditsBalanceRes {
  int? totalCredits;
  int? holdCredits;
  int? monthlyPlanCredits;
  int? purchasedCredits;
  int? bonusCredits;
  bool? purchasedCreditsLocked;
  bool? bonusCreditsLocked;
  String? subscriptionStatus;
  String? nextResetDate;

  creditsBalanceRes(
      {this.totalCredits,
      this.holdCredits,
      this.monthlyPlanCredits,
      this.purchasedCredits,
      this.bonusCredits,
      this.purchasedCreditsLocked,
      this.bonusCreditsLocked,
      this.subscriptionStatus,
      this.nextResetDate});

  creditsBalanceRes.fromJson(Map<String, dynamic> json) {
    totalCredits = json['totalCredits'];
    holdCredits = json['holdCredits'];
    monthlyPlanCredits = json['monthlyPlanCredits'];
    purchasedCredits = json['purchasedCredits'];
    bonusCredits = json['bonusCredits'];
    purchasedCreditsLocked = json['purchasedCreditsLocked'];
    bonusCreditsLocked = json['bonusCreditsLocked'];
    subscriptionStatus = json['subscriptionStatus'];
    nextResetDate = json['nextResetDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCredits'] = this.totalCredits;
    data['holdCredits'] = this.holdCredits;
    data['monthlyPlanCredits'] = this.monthlyPlanCredits;
    data['purchasedCredits'] = this.purchasedCredits;
    data['bonusCredits'] = this.bonusCredits;
    data['purchasedCreditsLocked'] = this.purchasedCreditsLocked;
    data['bonusCreditsLocked'] = this.bonusCreditsLocked;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['nextResetDate'] = this.nextResetDate;
    return data;
  }
}
