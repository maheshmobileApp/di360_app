import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/directors/model_class/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_all_banner_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_appointment_slots_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_business_details_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_community_status_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_res.dart';
import 'package:di360_flutter/feature/directors/model_class/get_team_members_res.dart';
import 'package:di360_flutter/feature/directors/querys/book_appointment_query.dart';
import 'package:di360_flutter/feature/directors/querys/community_register_query.dart';
import 'package:di360_flutter/feature/directors/querys/get_community_status_query.dart';
import 'package:di360_flutter/feature/directors/querys/get_dental_business_details_query.dart';
import 'package:di360_flutter/feature/directors/querys/get_time_slots_query.dart';
import 'package:di360_flutter/feature/directors/querys/directories_catagory_res.dart';
import 'package:di360_flutter/feature/directors/querys/directories_details_query.dart';
import 'package:di360_flutter/feature/directors/querys/get_all_banners.dart';
import 'package:di360_flutter/feature/directors/querys/get_director_based_on_catagory.dart';
import 'package:di360_flutter/feature/directors/querys/get_directors_query.dart';
import 'package:di360_flutter/feature/directors/querys/get_team_members.dart';
import 'package:di360_flutter/feature/directors/querys/partnership_request_query.dart';
import 'package:di360_flutter/feature/directors/respository/director_repository.dart';

class DirectorRepositoryImpl extends DirectorRepository {
  final HttpService http = HttpService();

  @override
  Future<List<Directories>> getDirectors(
      String catagoryId, String searchText) async {
    final res = (catagoryId.isEmpty && searchText.isEmpty)
        ? await http.query(getDirectorsQuery)
        : await http.query(GetDirectorBasedOnCatagoryQuery, variables: {
            "andList": [
              if (searchText.isNotEmpty)
                {
                  "name": {"_ilike": "%$searchText%"}
                },
              if (catagoryId.isNotEmpty)
                {
                  "directory_category_id": {"_eq": catagoryId}
                }
            ]
          });
    final result = DirectoriesData.fromJson(res);
    return result.directories ?? [];
  }

  @override
  Future<List<Banners>> getBannersList() async {
    final res = await http.query(getAllBannersQuery, variables: {
      "status": "APPROVED",
      "category_names": [
        "All Header Banners",
        "All Left Nav Small Banners",
        "All List View Large Banners"
      ],
      "banner_location": [
        "Web Header Directory",
        "Web Left Nav Directory",
        "Web Directory List View"
      ]
    });
    final result = BannersData.fromJson(res);
    return result.banners ?? [];
  }

  @override
  Future<List<DirectoryBusinessTypes>> directoriesCatagory() async {
    final res = await http.query(directoriesCatagoryQuery);
    final result = DirectoriesCatagoryData.fromJson(res);
    return result.directoryBusinessTypes ?? [];
  }

  @override
  Future<DirectoriesByPk?> directoriesDetailsQuery(String id) async {
    final res =
        await http.query(directories_Details_Query, variables: {"id": id});
    final result = DirectoryDetailsData.fromJson(res);
    return result.directoriesByPk;
  }

  @override
  Future<List<DirectoryAppointments>> appointmentsSlots(String id) async {
    final data = await http.query(getTimeSlots, variables: {"id": id});
    final res = SlotsData.fromJson(data);
    return res.directoryAppointments ?? [];
  }

  @override
  Future<List<DirectoryTeamMember>> getTeamMembers(String id) async {
    final data = await http.query(team_members_querys, variables: {"id": id});
    final res = TeamMembersData.fromJson(data);
    return res.directoryTeamMembers ?? [];
  }

  @override
  Future<dynamic> bookAppointmentDirector(variables) async {
    final data = await http.mutation(bookAppointmentQuery, variables);
    print(variables);
    return data;
  }

  @override
  Future<GetBusinessDetailsData> getBusinessDetails(variables) async {
    final res = await http.query(getDentalBusinessDetailsQuery, variables: variables);
    final data = GetBusinessDetailsData.fromJson(res);
    return data;
  }

  @override
  Future<CommunityStatusData> getCommunityStatus(variables) async {
    final res = await http.query(getCommunityStatusQuery, variables: variables);
    final data = CommunityStatusData.fromJson(res);
    print(variables);
    return data;
  }

  @override
  Future<dynamic> partnershipRegister(variables) async {
    final res = await http.query(partnershipRequestQuery, variables: variables);
    
    return res;
  }

  @override
  Future communityRegister(variables) async {
    final res = await http.mutation(communityRegisterQuery, variables);
    return res;
  }
}
