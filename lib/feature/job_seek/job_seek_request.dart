String job_list_request = '''query getAllJobs {
  jobs(
    order_by: { created_at: desc }
    where: { active_status: { _eq: "ACTIVE" }, status: { _in: ["APPROVE"] } }
  ) {
    id
    title
    j_type
    j_role
    description
    TypeofEmployment
    years_of_experience
    dental_practice_id
    dental_supplier_id
    location
    logo
    state
    city
    company_name
    salary
    website_url
    pay_range
    education
    video
    rate_billing
    created_at
    job_applicants_aggregate {
      aggregate {
        count
      }
    }
    country
    days_of_week
    current_company
    endDateToggle
    experience
    facebook_url
    hiring_period
    instagram_url
    is_featured
    closing_message
    closed_at
    clinic_logo
    banner_image
    availability_date
    address
    active_status
    pay_min
    pay_max
  }
}
''';


const String enquiryMutation =
    '''mutation insert_Enquiry_one(\$object: job_enquiries_insert_input!) {
        insert_job_enquiries_one(object: \$object) {
          id
          __typename
        }
      }''';
// const String applyJobMutation =
//     '''mutation insert_jobapplicants(\$applyJobobject:job_applicants_insert_input!) {
//   insert_job_applicants_one(object: \$applyJobobject) {
//     id
//   }
// } ''';

const String hireMeMutation =
    '''mutation insert_jobhirings(\$hireobject:jobhirings_insert_input!) {
  insert_jobhirings_one(object: \$hireobject) {
    id
  }
}''';

String applyJobMutation =
    r'''mutation insert_jobapplicants($applyJobobject: job_applicants_insert_input!) {
  insert_job_applicants_one(object: $applyJobobject) {
    id
    __typename
  }
}''';

String sendMessageMutation =
    r'''mutation insert_message_one($object: job_applicant_messages_insert_input!) {
  insert_job_applicant_messages_one(object: $object) {
    id
    __typename
  }
}''';

String jobApplyStatusQuery =
    r'''query getajobswithmyprofile($job_id: uuid, $dental_professional_id: uuid) {
  job_applicants(
    where: {
      _and: [
        { job_id: { _eq: $job_id } },
        { dental_professional_id: { _eq: $dental_professional_id } }
      ]
    }
  ) {
    id
    dental_professional_id
  }
}''';
