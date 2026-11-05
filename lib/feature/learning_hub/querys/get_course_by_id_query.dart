const String getCousreByIdQuery = r'''query getRecordById($id: uuid!) {
  courses_by_pk(id: $id) {
    id
    created_at
    updated_at
    course_name
    type
    presented_by_image
    presented_by_name
    status
    active_status
    afterwards_price
    presenters
    created_by_id
    endDate
    startDate
    cpd_points
    short_code
    dental_supplier {
      id
      logo
      __typename
    }
    __typename
  }
}''';
