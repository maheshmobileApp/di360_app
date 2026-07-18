abstract class ClientsRepository {
  Future<dynamic> getClients();
  Future<dynamic> getClientsBasedOnUserType();
  Future<dynamic> deleteUser(String clientId);
  Future<dynamic> inactiveClient(String clientId);
  Future<dynamic> resendMail(String clientId);
  Future<dynamic> adminApproveUser(String clientId);
}
