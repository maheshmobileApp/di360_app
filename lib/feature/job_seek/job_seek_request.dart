String job_list_request = r'''query getMarketplaceJobs($limit: Int, $offset: Int, $where: jobs_bool_exp, $order_by: [jobs_order_by!]) {
  jobs(where: $where, order_by: $order_by, limit: $limit, offset: $offset) {
    id
    title
    j_type
    j_role
    dental_supplier_id
    dental_practice_id
    description
    TypeofEmployment
    availability_date
    active_status
    location
    logo
    city
    company_name
    status
    created_at
    __typename
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
