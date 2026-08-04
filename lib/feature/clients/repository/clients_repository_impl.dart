import 'package:di360_flutter/core/api_constants.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/clients/querys/delete_user_data_query.dart';
import 'package:di360_flutter/feature/clients/querys/get_client_based_on_user_type.dart';
import 'package:di360_flutter/feature/clients/querys/get_client_query.dart';
import 'package:di360_flutter/feature/clients/querys/inactive_client_query.dart';
import 'package:di360_flutter/feature/clients/repository/clients_repository.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  final HttpService http = HttpService();

  @override
  Future<dynamic> getClients() async {
    final response = await http.query(getClientQuery);
    return response;
  }

  @override
  Future<dynamic> getClientsBasedOnUserType() async {
    final response = await http.query(getClientBasedOnUserTypeQuery);
    return response;
  }

  @override
  Future<dynamic> deleteUser(String clientId) async {
    final response = await http.mutation(deleteUserDataQuery, {"id": clientId});
    return response;
  }

  @override
  Future<dynamic> inactiveClient(String clientId) async {
    final response = await http.mutation(inactiveClientQuery, {
      "id": clientId,
      "updateObj": {"status": "INACTIVE"}
    });
    return response;
  }

  @override
  Future<dynamic> resendMail(String clientId) async {
    final response = await http.post(ApiConst.resendMail, {"id": clientId});
    return response;
  }

  @override
  Future<dynamic> adminApproveUser(String clientId) async {
    final response = await http.post(ApiConst.adminApproveUser + clientId, {});
    return response;
  }
}
