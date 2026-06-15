import 'package:di360_flutter/feature/clients/model_class/get_client_response.dart';
import 'package:di360_flutter/feature/clients/repository/clients_repository_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class ClientsProvider extends ChangeNotifier {
  ClientsRepositoryImpl clientsRepositoryImpl = ClientsRepositoryImpl();

  int selectedStatus = 0;
  int selectedCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "ALL", "count": 1049},
    {"title": "DENTAL PROFESSIONAL", "count": 505},
    {"title": "INDUSTRY PARTNERS", "count": 335},
    {"title": "DENTAL PRACTICE", "count": 209},
    {"title": "TEAM MEMBER", "count": 71},
  ];

  List<Clients>? clients = [];

  Future<void> fetchClients(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final response = await clientsRepositoryImpl.getClients();
    if (response != null) {
      final clientsResponse = ClientsData.fromJson(response);
      clients = clientsResponse.clients;
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
