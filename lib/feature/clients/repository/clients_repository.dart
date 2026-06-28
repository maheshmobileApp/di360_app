abstract class ClientsRepository {
  Future<dynamic> getClients();
  Future<dynamic> getClientsBasedOnUserType();
}