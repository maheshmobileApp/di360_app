import 'package:flutter/material.dart';

class MyCatalogueScreen extends StatefulWidget {
  const MyCatalogueScreen({super.key});

  @override
  State<MyCatalogueScreen> createState() => _MyCatalogueScreenState();
}

class _MyCatalogueScreenState extends State<MyCatalogueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<CatalogueItem> allItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    loadMockData();
  }

  void loadMockData() {
    allItems = [
      CatalogueItem(
        id: "1",
        name: "Braces",
        category: "Category name",
        views: 233,
        schedulerDate: DateTime(2025, 6, 30),
        expiryDate: DateTime(2025, 7, 31),
        status: "approved",
      ),
      CatalogueItem(
        id: "2",
        name: "Braces",
        category: "Category name",
        views: 123,
        schedulerDate: DateTime(2025, 6, 30),
        expiryDate: DateTime(2025, 7, 31),
        status: "pending",
      ),
    ];
  }

  List<CatalogueItem> filterItems(String status) {
    if (status == "all") return allItems;
    return allItems.where((item) => item.status == status).toList();
  }

  void deleteItem(String id) {
    setState(() {
      allItems.removeWhere((item) => item.id == id);
    });
  }

  void toggleStatus(CatalogueItem item) {
    setState(() {
      if (item.status == "approved") {
        item.status = "inactive";
      } else if (item.status == "inactive") {
        item.status = "approved";
      }
    });
  }

  void editItem(CatalogueItem item) {
    // navigate to edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Edit tapped for ${item.name}")),
    );
  }

  void viewItem(CatalogueItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("View tapped for ${item.name}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statuses = ["all", "pending", "approved", "rejected"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dental Interface"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: "All (${filterItems("all").length})"),
            Tab(text: "Pending (${filterItems("pending").length})"),
            Tab(text: "Approved (${filterItems("approved").length})"),
            Tab(text: "Rejected (${filterItems("rejected").length})"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: statuses.map((status) {
          final items = filterItems(status);
          return items.isEmpty
              ? const Center(child: Text("No items found"))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CatalogueCard(
                      item: items[index],
                      onView: viewItem,
                      onEdit: editItem,
                      onDelete: deleteItem,
                      onToggleStatus: toggleStatus,
                    );
                  },
                );
        }).toList(),
      ),
    );
  }
}

class CatalogueCard extends StatelessWidget {
  final CatalogueItem item;
  final void Function(CatalogueItem) onView;
  final void Function(CatalogueItem) onEdit;
  final void Function(String) onDelete;
  final void Function(CatalogueItem) onToggleStatus;

  const CatalogueCard({
    super.key,
    required this.item,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "inactive":
        return Colors.blue;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // String formatDate(DateTime date) {
  //   return DateFormat("MMM dd, yyyy").format(date);
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(item.status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.status.capitalize(),
                style: TextStyle(
                  color: getStatusColor(item.status),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${item.category}"),
            Text("Views: ${item.views}"),
            Text("Scheduler date: ${item.schedulerDate}"),
            Text("Expiry date: ${item.expiryDate}"),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'view':
                onView(item);
                break;
              case 'edit':
                onEdit(item);
                break;
              case 'toggle':
                onToggleStatus(item);
                break;
              case 'delete':
                onDelete(item.id);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'view', child: Text("View")),
            const PopupMenuItem(value: 'edit', child: Text("Edit")),
            PopupMenuItem(
              value: 'toggle',
              child: Text(item.status == "approved" ? "Inactive" : "Activate"),
            ),
            const PopupMenuItem(value: 'delete', child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}

class CatalogueItem {
  final String id;
  final String name;
  final String category;
  final int views;
  final DateTime schedulerDate;
  final DateTime expiryDate;
  String status;

  CatalogueItem({
    required this.id,
    required this.name,
    required this.category,
    required this.views,
    required this.schedulerDate,
    required this.expiryDate,
    required this.status,
  });
}
