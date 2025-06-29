
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
