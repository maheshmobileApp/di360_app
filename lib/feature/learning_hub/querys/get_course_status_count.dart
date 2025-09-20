const String getCourseStatusCount = r'''
query getCourseStatusCounts {
  all: courses_aggregate {
    aggregate {
      count
    }
  }
  approve: courses_aggregate(where: {status: {_eq: "APPROVE"}}) {
    aggregate {
      count
    }
  }
  rejected: courses_aggregate(where: {status: {_eq: "REJECT"}}) {
    aggregate {
      count
    }
  }
  draft: courses_aggregate(where: {status: {_eq: "DRAFT"}}) {
    aggregate {
      count
    }
  }
    pending: courses_aggregate(where: {status: {_eq: "PENDING"}}) {
    aggregate {
      count
    }
  }
}
''';
