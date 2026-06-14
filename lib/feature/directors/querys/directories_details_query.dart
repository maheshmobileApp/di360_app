const String directories_Details_Query = r'''
query getDirectory($id: uuid!, $member_id: uuid!) {
  directories_by_pk(id: $id) {
    id
    description
    name
    email
    business_email
    phone
    address
    website
    alt_phone
    mobile_number
    hobbies
    university_school
    abn_acn
    status
    company_name
    profession
    membership_link
    partnership_link
    business_name
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
    email_visibility
    phone_visibility
    dental_supplier {
      first_name
      last_name
      community_status
      community_id
      community_members(where: {member_id: {_eq: $member_id}}, limit: 1) {
        status
        __typename
      }
      partnership_members(
        where: {member_id: {_eq: $member_id}}
        limit: 1
        order_by: {created_at: desc}
      ) {
        status
        __typename
      }
      __typename
    }
    dental_practice {
      first_name
      last_name
      __typename
    }
    dental_professional {
      first_name
      last_name
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
    directory_partners {
      name
      description
      image
      attachments
      show_community_user
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
  loggedInSupplier: dental_suppliers(where: {id: {_eq: $member_id}}, limit: 1) {
    name
    business_name
    __typename
  }
  loggedInProfessional: dental_professionals(
    where: {id: {_eq: $member_id}}
    limit: 1
  ) {
    first_name
    last_name
    __typename
  }
}
''';
