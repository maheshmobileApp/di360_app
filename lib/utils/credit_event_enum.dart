enum CreditEvent {
  newsFeedPost("News Feed Post"),
  learningHubListing("Learning Hub Listing"),
  jobListing("Job Listing"),
  catalogueListing("Catalogue Listing"),
  bannerAdvertisement("Banner Advertisement"),
  talentSearch("Talent Search");

  final String value;

  const CreditEvent(this.value);
}