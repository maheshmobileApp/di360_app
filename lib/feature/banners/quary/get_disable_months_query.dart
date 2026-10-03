const String getDisableMonthsQuery = r'''query getDisabledMonths($where: banners_bool_exp) {
  banners(where: $where) {
    id
    schedule_date
    __typename
  }
}''';