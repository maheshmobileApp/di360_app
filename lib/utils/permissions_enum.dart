enum ModulePermission {
  // Marketplace
  newsfeedMarketplace('NEWSFEED_MARKETPLACE'),
  directoryMarketplace('DIRECTORY_MARKETPLACE'),
  learningHubMarketplace('LEARNING_HUB_MARKETPLACE'),
  jobSeekMarketplace('POPULAR_JOBS_MARKETPLACE'),
  catalogueMarketplace('CATALOGUE_MARKETPLACE'),
  suppliesMarketplace('SUPPLIES_MARKETPLACE'),

  // Modules
  newsfeedModule('NEWSFEED_MODULE'),
  popularJobsModule('POPULAR_JOBS_MODULE'),
  talentSearchModule('TALENT_SEARCH_MODULE'),
  cataloguesModule('CATALOGUES_MODULE'),
  directoryModule('DIRECTORY_MODULE'),
  learningHubModule('LEARNING_HUB_MODULE'),
  usedSuppliesModule('USED_SUPPLIES_MODULE'),
  suppliesModule('SUPPLIES_MODULE'),
  buySellModule('BUY_SELL_MODULE'),
  viewProfileModule('VIEW_PROFILE_MODULE'),
  bannersModule('BANNERS_MODULE'),
  accountPayRequestsModule('ACCOUNT_PAY_REQUESTS_MODULE'),
  supportRequestModule('SUPPORT_REQUEST_MODULE'),
  teamMembersModule('TEAM_MEMBERS_MODULE'),
  marketingModule('MARKETING_MODULE');

  const ModulePermission(this.value);

  final String value;

  static ModulePermission? fromValue(String value) {
    try {
      return ModulePermission.values.firstWhere(
        (e) => e.value == value,
      );
    } catch (_) {
      return null;
    }
  }
}