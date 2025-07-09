## Job Seeker Filter
For load the filter need to get few data from the server
1. Get Profession:
2.Get Work Type:


## Get Profession Query
query getAllJobsRoleList {
  jobs_role_list(order_by: {created_at: desc}) {
    id
    role_name
    created_at
    updated_at
    created_by
    created_by_user_id
    __typename
  }
}

## Get Profession Response

{
  "data": {
    "jobs_role_list": [
      {
        "id": "ceb24d6f-33a1-408a-8014-14b94a5df55a",
        "role_name": "Surgen",
        "created_at": "2025-05-08T06:14:40.163764+00:00",
        "updated_at": "2025-05-08T06:14:40.163764+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "jobs_role_list"
      },
      {
        "id": "020c842c-96e3-4885-bbb3-5992fe1c185d",
        "role_name": "Dentist",
        "created_at": "2025-05-06T05:59:54.958621+00:00",
        "updated_at": "2025-05-06T05:59:54.958621+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "jobs_role_list"
      },
      {
        "id": "a0f40004-33df-463d-a032-ca1339a529c4",
        "role_name": "Dental Hygienist",
        "created_at": "2025-04-28T06:08:06.133762+00:00",
        "updated_at": "2025-04-28T06:08:06.133762+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "jobs_role_list"
      },
      {
        "id": "4abbbdf6-187f-4e41-8221-acc14b3cbd8d",
        "role_name": "Dental Prosthetist",
        "created_at": "2025-04-22T06:32:56.042658+00:00",
        "updated_at": "2025-04-22T06:32:56.042658+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "jobs_role_list"
      },
      {
        "id": "b1b92ec8-4de3-42f5-bf9c-b95b29bdb1b4",
        "role_name": "Dental Specialist",
        "created_at": "2025-04-22T06:29:25.308915+00:00",
        "updated_at": "2025-04-22T06:29:25.308915+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "jobs_role_list"
      }
    ]
  }
}

## Get Work Type:
query getAllEmployeeTypeList {
  job_types(order_by: {created_at: desc}) {
    id
    employee_type_name
    created_at
    updated_at
    created_by
    created_by_user_id
    __typename
  }
}

## Get Work Type Response

{
  "data": {
    "job_types": [
      {
        "id": "b9634a5e-3589-40e6-8456-5c0b0d9bd521",
        "employee_type_name": "Locum",
        "created_at": "2025-06-12T09:38:26.090647+00:00",
        "updated_at": "2025-06-12T09:38:26.090647+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "job_types"
      },
      {
        "id": "75015763-cd6c-4dff-bc7f-66c491d83086",
        "employee_type_name": "Contract",
        "created_at": "2025-04-26T11:29:47.509156+00:00",
        "updated_at": "2025-04-28T08:17:17.254643+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "job_types"
      },
      {
        "id": "606fe250-13b7-443d-9278-766275e6acf9",
        "employee_type_name": "Casual",
        "created_at": "2025-04-23T08:12:02.46265+00:00",
        "updated_at": "2025-04-23T09:48:48.550756+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "job_types"
      },
      {
        "id": "37bdfcfd-6542-43e4-a2d9-f02968d82200",
        "employee_type_name": "Part Time",
        "created_at": "2025-04-22T10:49:23.714643+00:00",
        "updated_at": "2025-04-22T10:49:23.714643+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "job_types"
      },
      {
        "id": "9671b01c-5e48-420d-b0c7-2e56701dd685",
        "employee_type_name": "Full Time",
        "created_at": "2025-04-22T10:36:26.221066+00:00",
        "updated_at": "2025-04-22T10:36:26.221066+00:00",
        "created_by": "ADMIN",
        "created_by_user_id": "49495d3b-9be3-425f-8220-ecc09b802375",
        "__typename": "job_types"
      }
    ]
  }
}

## Get Job Seeker Filter Query
Query:

query getalljobsFilter($where: jobs_bool_exp!) {
  jobs(where: $where, order_by: {created_at: desc}) {
    id
    title
    j_type
    j_role
    description
    TypeofEmployment
    years_of_experience
    availability_date
    dental_practice_id
    dental_supplier_id
    active_status
    location
    logo
    state
    city
    salary
    company_name
    website_url
    pay_range
    education
    video
    closed_at
    status
    offered_benefits
    country
    endDateToggle
    pay_max
    pay_min
    hiring_period
    no_of_people
    rate_billing
    linkedin_url
    instagram_url
    facebook_url
    clinic_logo
    timings
    banner_image
    timingtoggle
    created_at
    job_applicants_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}

Variable:


{
  "where": {
    "_and": [
      {
        "status": {
          "_eq": "APPROVE"
        }
      },
      {
        "j_role": {
          "_in": [
            "Surgen",
            "Dentist",
            "Dental Hygienist",
            "Dental Prosthetist",
            "Dental Specialist"
          ]
        }
      },
      {
        "TypeofEmployment": {
          "_has_keys_any": [
            "Locum",
            "Contract",
            "Casual",
            "Full Time",
            "Part Time"
          ]
        }
      },
      {
        "years_of_experience": {
          "_eq": "3-5"
        }
      },
      {
        "availability_date": {
          "_has_keys_any": [
            "2025-07-11",
            "2025-07-18",
            "2025-07-17",
            "2025-07-16",
            "2025-07-07",
            "2025-07-09",
            "2025-07-08",
            "2025-07-10",
            "2025-07-12"
          ]
        }
      }
    ]
  }
}
