const String catalogueViewQuery = r'''
query getByPk($id: uuid!) {
  catalogues_by_pk(id: $id) {
    id
    title
    attachment
    thumbnail_image
    catalogue_status
    schedulerDay
    months_count
    expiryDay
    catalogue_category {
      id
      name
      __typename
    }
    catalogue_sub_category {
      id
      name
      __typename
    }
    j_catalogues_catalogue_tags {
      id
      catalogue_id
      catalogue_tag_id
      __typename
    }
    __typename
  }
}
''';
