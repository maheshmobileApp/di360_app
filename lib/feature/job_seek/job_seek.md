
## Apply job



{"operationName":"insert_message_one","variables":{"object":{"job_applicant_id":"ac515f99-deed-4de5-ab3a-ba20a4ca100e","message":"werqwrwq","message_from":"87692fe6-21ea-48d5-98f3-9896a634ca8a"}},"query":"mutation insert_message_one($object: job_applicant_messages_insert_input!) {\n  insert_job_applicant_messages_one(object: $object) {\n    id\n    __typename\n  }\n}\n"}

mutation insert_jobapplicants($applyJobobject:job_applicants_insert_input!) {
  insert_job_applicants_one(object: $applyJobobject) {
    id
  }
}

{"operationName":"insert_jobapplicants","variables":{"applyJobobject":{"id":"ac83306e-b76d-4f98-beaa-4ee85f94ee65","job_id":"6180a6d2-5207-4e99-abd5-90612bed7e4a","dental_professional_id":"87692fe6-21ea-48d5-98f3-9896a634ca8a","message":"Apply Message","first_name":"test"}},"query":"mutation insert_jobapplicants($applyJobobject: job_applicants_insert_input!) {\n  insert_job_applicants_one(object: $applyJobobject) {\n    id\n    __typename\n  }\n}\n"}



Request Pyalod:

{"applyJobobject":{
  "job_id": "5eecb6d4-5968-4b85-947a-b56fd378357d",
        "dental_professional_id":"e3103405-adce-4ae8-af81-3cac95a4af84",
        "message": "New Job Applly",
        "attachments":[{ "url": "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/25848b58-db8f-411c-863d-45bbf987f3f5", "name": "Dental Interface_Google Oauth integration.docx", "type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document" }
]
}
}

## HireME

mutation insert_jobhirings($hireobject:jobhirings_insert_input!) {
  insert_jobhirings_one(object: $hireobject) {
    id
  }
}

{"hireobject":{
  "dental_supplier_id":null,
        "dental_professional_id":"e3103405-adce-4ae8-af81-3cac95a4af84",
        "message": "New Job Applly",
        "attachments":[{ "url": "https://dentalerp-dev.s3-ap-southeast-2.amazonaws.com/uploads360/project/25848b58-db8f-411c-863d-45bbf987f3f5", "name": "Dental Interface_Google Oauth integration.docx", "type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document" }
]
}
}

## Enquiry
mutation insert_jobenquiries($jobenquiryobject:job_enquiries_insert_input!) {
  insert_job_enquiries_one(object: $jobenquiryobject) {
    id
  }
}

{"jobenquiryobject":{
  "dental_supplierid":null,
    "job_id":"61c87b15-781e-43cf-b80a-41960c1e6fe7",
     "enquiry_userid":"1d0f1ca1-2658-4869-85d0-6f098bc600a1",
        "enquiry_description": "New Job Applly"

}
}


https://dental-360-dev.hasura.app/v1/graphql



{"operationName":"insert_Enquiry_one","variables":{"object":{"enquiry_description":"need this job ","job_id":"3b65f260-a014-4b52-a0a8-22d9a1f99a8d","enquiry_userid":"87692fe6-21ea-48d5-98f3-9896a634ca8a"}},


"query":"mutation insert_Enquiry_one($object: job_enquiries_insert_input!) {\n  insert_job_enquiries_one(object: $object) {\n    id\n    __typename\n  }\n}\n"}



// New method for inserting job enquiry
  Future<Map<String, dynamic>?> insertEnquiry({
    required String enquiryDescription,
    required String jobId,
    required String enquiryUserId,
    bool showLoading = true,
  }) async {
    const String document = '''
      mutation insert_Enquiry_one(\$object: job_enquiries_insert_input!) {
        insert_job_enquiries_one(object: \$object) {
          id
          __typename
        }
      }
    ''';

    final variables = {
      "object": {
        "enquiry_description": enquiryDescription,
        "job_id": jobId,
        "enquiry_userid": enquiryUserId,
      }
    };

    try {
      final response = await mutation(document, variables, showLoading: showLoading);
      return response;
    } catch (e, s) {
      print("Error inserting enquiry: $e, $s");
      return null;
    }
  }