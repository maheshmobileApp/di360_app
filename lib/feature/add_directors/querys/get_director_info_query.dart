const String getDirectorInfoQuery = r'''
query getUeserPracDirectory($id: uuid!) {
  directories(where: {dental_practice_id: {_eq: $id}}) {
    id
    description
    name
    email
    business_email
    business_name
    phone
    mobile_number
    address
    latitude
    longitude
    alt_phone
    type
    abn_acn
    company_name
    professionType
    directory_category_id
    logo
    banner_image
    dental_practice {
      id
      business_name
      __typename
    }
    directory_documents {
      name
      attachment
      __typename
    }
    directory_locations {
      id
      media_name
      media_link
      status
      week_name
      clinic_time
      __typename
    }
    directory_services {
      id
      name
      image
      description
      __typename
    }
    directory_certifications {
      id
      title
      attachments
      __typename
    }
    directory_achievements {
      id
      title
      attachments
      __typename
    }
    directory_appointments {
      id
      __typename
    }
    directory_team_members(where: {show_in_our_team: {_eq: "true"}}) {
      id
      name
      specialization
      image
      phone
      email
      subrub
      state
      __typename
    }
    directory_gallery_posts {
      id
      image
      before_image
      after_image
      banner_image
      profile_image
      logo
      before_and_after
      __typename
    }
    directory_testimonials {
      id
      profile_image
      name
      message
      msg_pic
      __typename
    }
    directory_faqs {
      id
      question
      answer
      __typename
    }
    __typename
  }
}
''';

const String getSuppilerDirectorInfoQuery = r'''
query getUeserSupDirectory($id: uuid!) {
  directories(where: {dental_supplier_id: {_eq: $id}}) {
    id
    description
    name
    type
    abn_acn
    community_status
    community_id
    company_name
    professionType
    professiontype
    directory_category_id
    email
    business_email
    business_name
    phone
    address
    latitude
    longitude
    alt_phone
    banner_image
    logo
    directory_documents {
      name
      attachment
      __typename
    }
    directory_locations {
      id
      media_name
      media_link
      status
      week_name
      clinic_time
      __typename
    }
    directory_services {
      id
      name
      image
      description
      __typename
    }
    directory_certifications {
      id
      title
      attachments
      __typename
    }
    directory_achievements {
      id
      title
      attachments
      __typename
    }
    directory_appointments {
      id
      __typename
    }
    directory_team_members(where: {show_in_our_team: {_eq: "true"}}) {
      id
      name
      specialization
      image
      phone
      email
      subrub
      state
      location
      __typename
    }
    directory_gallery_posts {
      id
      image
      before_image
      after_image
      banner_image
      profile_image
      logo
      before_and_after
      __typename
    }
    directory_testimonials {
      id
      profile_image
      name
      message
      msg_pic
      role
      __typename
    }
    directory_faqs {
      id
      question
      answer
      __typename
    }
    dental_supplier {
      business_name
      __typename
    }
    __typename
  }
}
''';