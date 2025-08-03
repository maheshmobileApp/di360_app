const String directories_Details_Query = r'''
query getDirectory($id: uuid!) {
  directories_by_pk(id: $id) {
    id
    description
    name
    email
    phone
    address
    alt_phone
    hobbies
    university_school
    abn_acn
    company_name
    profession
    type
    education
    profession_type
    designation
    working_at
    banner_image
    logo
    latitude
    longitude
    profile_image
    dental_practice_id
    dental_professional_id
    dental_supplier_id
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
    directory_achievements {
      id
      title
      attachments
      __typename
    }
    directory_certifications {
      id
      title
      attachments
      __typename
    }
    directory_appointment_slots {
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
    __typename
  }
}
''';