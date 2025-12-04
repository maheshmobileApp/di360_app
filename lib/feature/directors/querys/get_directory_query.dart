const String getDirectoryQuery = r'''
query getDirectory($id: uuid!){
    directories_by_pk(id:$id){
      id
      description
      name
      email
      phone
      address
      website
      alt_phone
      hobbies
      university_school
      abn_acn
      status
      company_name
      profession
      membership_link
      partnership_link
      business_name
      company_name
      community_status
      community_id
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

      dental_supplier {
        first_name
        last_name
      }
      dental_practice {
        first_name
        last_name
      }
      dental_professional {
        first_name
        last_name
      }

      directory_documents {
        name
        attachment
      }
      directory_locations {
        id
        media_name
        media_link
        status
        week_name
        clinic_time
      }

      directory_services {
        id
        name
        image
        description
      }
      directory_achievements {
        id
        title
        attachments
      }
      directory_certifications {
        id
        title
        attachments
      }
      directory_appointment_slots {
        id
      }
      directory_team_members(where: { show_in_our_team: { _eq: "true" } }) {
        id
        name
        specialization
        image
        phone
        email
        subrub
        state
        location
      }
      directory_partners {
        name
        description
        image
        attachments
        show_community_user
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
      }

      directory_testimonials {
        id
        profile_image
        name
        message
        msg_pic
        role
      }

      directory_faqs {
        id
        question
        answer
      }
    }
  }

''';
