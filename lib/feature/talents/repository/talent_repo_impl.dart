

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_seek/talents_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo.dart';


class TalentRepoImpl extends TalentRepository {
  final HttpService _http = HttpService();
  @override
  Future<List<JobProfile>> getTalentDetails() async {
    final jobsData = await _http.query(talentsRequest);
    final result = TalentsData.fromJson(jobsData);
    return result.jobProfiles;
  }
  
  @override
  Future<bool> hireMe() {
    // TODO: implement hireMe
    throw UnimplementedError();
  }
}


/*

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
 */