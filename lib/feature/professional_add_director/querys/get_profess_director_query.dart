const String getProfessDirectorQuery = r'''
query getUeserProfDirectory($id: uuid!) {
  directories(where: {dental_professional_id: {_eq: $id}}) {
    id
    description
    name
    phone
    email
    banner_image
    profile_image
    abn_acn
    company_name
    description
    type
    address
    profession_type
    directory_category_id
    working_at
    education
    university_school
    hobbies
    alt_phone
    profession
    latitude
    longitude
    designation
    directory_documents {
      id
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
      show_in_appointments
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
      location
      show_in_our_team
      show_in_appointments
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
      role
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