import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/clients/clients_provider/clients_provider.dart';
import 'package:di360_flutter/feature/clients/view/client_card_widget.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ClientsProvider>(context, listen: false)
          .fetchClients(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Clients"), centerTitle: true, actions: [
            GestureDetector(
                onTap: () => logOutAlert(context),
                child:
                    SvgPicture.asset(ImageConst.logout, width: 25, height: 25)),
            addHorizontal(16)
          ]),
          body: Column(
            children: [
              _statusTabs(provider),
              addVertical(12),
              _categoryTabs(provider),
              addVertical(16),
              // _searchField(),
              // const SizedBox(height: 12),
              // _filters(),
              // const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.clients?.length,
                  itemBuilder: (context, index) {
                    return ClientCard(client: provider.clients?[index]);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _statusTabs(ClientsProvider provider) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => provider.changeStatus(0),
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: provider.selectedStatus == 0
                        ? Colors.orange
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text("ACTIVE 1049",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => provider.changeStatus(1),
            child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: provider.selectedStatus == 1
                              ? Colors.orange
                              : Colors.transparent,
                          width: 3)),
                ),
                child: Text("INACTIVE 21",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
        ),
      ],
    );
  }

  Widget _categoryTabs(ClientsProvider provider) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final item = provider.categories[index];

          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ChoiceChip(
              label: Text(
                "${item['title']} (${item['count']})",
              ),
              selected: provider.selectedCategory == index,
              onSelected: (_) {
                provider.changeCategory(index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _searchField() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
          decoration: InputDecoration(
              hintText: "Search by Name, Email",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder())),
    );
  }

  Widget _filters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
                value: "All Plans",
                items: const [
                  DropdownMenuItem(value: "All Plans", child: Text("All Plans"))
                ],
                onChanged: (_) {}),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
                value: "All",
                items: const [
                  DropdownMenuItem(value: "All", child: Text("All"))
                ],
                onChanged: (_) {}),
          ),
        ],
      ),
    );
  }
}
