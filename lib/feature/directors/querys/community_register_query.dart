const String communityRegisterQuery =
    r'''mutation handleCommunityMembership($input: HandleCommunityMembershipInput!) {
  handleCommunityMembership(input: $input) {
    success
    __typename
  }
}
''';
