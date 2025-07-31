{
    dental_practice_id: "a1111111-1111-1111-1111-111111111111",
    job_role_id: "b2222222-2222-2222-2222-222222222222",
    job_type_id: "c3333333-3333-3333-3333-333333333333",
    title: "Dental Assistant - Full Time",
    description: "We are looking for a full-time dental assistant to join our team.",
    roles_and_responsibilities: "Assisting with procedures, sterilizing instruments, maintaining patient records.",
    address: {
      street: "123 Dental Lane",
      city: "Sydney",
      postcode: "2000"
    },
    days_of_week: ["Monday", "Wednesday", "Friday"],
    timings: "9 AM - 5 PM",
    status: "OPEN",
    is_featured: true,
    banner_image: {
      url: "https://example.com/banner.jpg",
      name: "job-banner.jpg"
    },
    video: {
      url: "https://example.com/intro-video.mp4"
    },
    website_url: "https://dentalclinic.com.au/careers",
    number_of_positions: 2,
    state: "NSW",
    city: "Sydney",
    location: "Sydney CBD",
    TypeofEmployment: ["Full-time", "On-site"],
    logo: "https://example.com/logo.png",
    salary: "Hourly",
    dental_supplier_id: "d4444444-4444-4444-4444-444444444444",
    j_type: "Dental Assistant",
    j_role: "Assistant",
    company_name: "Bright Smile Dental",
    pay_range: "$30 - $40/hour",
    education: "Certificate III in Dental Assisting",
    experience: "1-2 years preferred",
    skills: ["X-ray certification", "Chair-side assisting"],
    jobexperiences: ["Assisted with over 500 procedures", "Worked with diverse patient demographics"],
    job_location: "Sydney CBD",
    job_designation: "Junior Dental Assistant",
    current_company: "Happy Teeth Pty Ltd",
    active_status: "ACTIVE",
    country: "Australia",
    hiring_period: "3 months",
    no_of_people: "2",
    rate_billing: "$35/hour",
    offered_supplement: "Health Insurance",
    facebook_url: "https://facebook.com/brightsmile",
    instagram_url: "https://instagram.com/brightsmile",
    linkedin_url: "https://linkedin.com/company/brightsmile",
    twitter_url: "https://twitter.com/brightsmile",
    endDateToggle: "YES",
    offered_benefits: ["Health insurance", "Dental care", "Paid leave"],
    timingtoggle: "FIXED",
    clinic_logo: {
      url: "https://example.com/clinic-logo.png"
    },
    pay_min: 30,
    pay_max: 40,
    years_of_experience: "1-3 years",
    availability_date: ["2025-08-01"],
    auto_expiry_date: "2025-09-01",
    active_status_feed: "PENDING",
    feed_type: "JOBS"
  }


  mutation insert_jobpost($postjobObj:jobs_insert_input!) {
  insert_jobs_one(object: $postjobObj) {
    id
  }
}