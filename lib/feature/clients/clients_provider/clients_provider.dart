import 'package:di360_flutter/feature/clients/model_class/get_client_count_response.dart';
import 'package:di360_flutter/feature/clients/model_class/get_client_response.dart';
import 'package:di360_flutter/feature/clients/repository/clients_repository_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class ClientsProvider extends ChangeNotifier {
  ClientsRepositoryImpl clientsRepositoryImpl = ClientsRepositoryImpl();

  int selectedStatus = 0;
  int selectedCategory = 0;

  ClientCountData? clientCountData;

  List<Map<String, dynamic>> get categories => [
        {"title": "ALL", "count": clientCountData?.allActive?.aggregate?.count},
        {
          "title": "DENTAL PROFESSIONAL",
          "count": clientCountData?.professionalActive?.aggregate?.count
        },
        {
          "title": "INDUSTRY PARTNERS",
          "count": clientCountData?.supplierActive?.aggregate?.count
        },
        {
          "title": "DENTAL PRACTICE",
          "count": clientCountData?.practiceActive?.aggregate?.count
        },
        {
          "title": "TEAM MEMBER",
          "count": clientCountData?.teamMemberActive?.aggregate?.count
        }
      ];

  List<Clients>? clients = [];

  Future<void> fetchClients(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.getClients();
    if (response != null) {
      getClientsCountData(context);
      final clientsResponse = ClientsData.fromJson(response);
      clients = clientsResponse.clients;
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> getClientsCountData(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.getClientsBasedOnUserType();
    if (response != null) {
      final clientsCountData = ClientCountData.fromJson(response);
      clientCountData = clientsCountData;
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> deleteUserData(BuildContext context, String clientId) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.deleteUser(clientId);
    if (response['delete_clients'] != null) {
      fetchClients(context);
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> inactiveClient(BuildContext context, String clientId) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.inactiveClient(clientId);
    if (response['update_clients_by_pk'] != null) {
      fetchClients(context);
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> reSendVerifyMail(BuildContext context, String clientId) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.resendMail(clientId);
    if (response != null) {
      scaffoldMessenger('Verification email resent successfully');
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> adminApproveUser(BuildContext context, String clientId) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.adminApproveUser(clientId);
    if (response != null) {
      scaffoldMessenger('User approved successfully');
    }
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  void changeStatus(int index) {
    selectedStatus = index;
    notifyListeners();
  }

  void changeCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }
}
