import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/clients/querys/get_client_query.dart';
import 'package:di360_flutter/feature/clients/repository/clients_repository.dart';

class ClientsRepositoryImpl extends ClientsRepository {
  final HttpService http = HttpService();

  @override
  Future<dynamic> getClients() async {
    final response = await http.query(getClientQuery);
    return response;
  }
}
