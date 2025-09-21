const String deleteJobProfile = r'''
mutation DeleteJob($id: uuid!) {
         delete_job_profiles_by_pk(id: $id) {
           id
         }
         delete_talent_enquiries(where: {talent_id: { _eq: $id }}){
         affected_rows
         }

         delete_talents_message(where: {talent_id: { _eq: $id }}){
         affected_rows
         }

       }
''';

