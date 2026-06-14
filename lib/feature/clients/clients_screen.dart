import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  int selectedStatus = 0;
  int selectedCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "ALL", "count": 1049},
    {"title": "DENTAL PROFESSIONAL", "count": 505},
    {"title": "INDUSTRY PARTNERS", "count": 335},
    {"title": "DENTAL PRACTICE", "count": 209},
    {"title": "TEAM MEMBER", "count": 71},
  ];

  final List<UserModel> users = [
    UserModel(
      name: "Neil",
      email: "Strongdental@yopmail.com",
      type: "SUPPLIER",
      phone: "+61476444767",
      date: "13 Jun 2026, 09:02 PM",
      plan: "Enterprise",
      signupType: "Manual (Instagram)",
      status: "Active",
    ),
    UserModel(
      name: "Joy",
      email: "Joyprofessional@yopmail.com",
      type: "PROFESSIONAL",
      phone: "+61456799797",
      date: "13 Jun 2026, 08:30 PM",
      plan: "Standard",
      signupType: "Mobile",
      status: "Active",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(title: const Text("Clients"), elevation: 0),
      body: Column(
        children: [
          _buildStatusTabs(),
          const SizedBox(height: 10),
          _buildCategoryTabs(),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 12),
          _buildFilters(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(user: users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedStatus = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedStatus == 0
                          ? Colors.orange
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "ACTIVE ",
                          style: TextStyle(
                            color: selectedStatus == 0
                                ? Colors.orange
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const TextSpan(
                          text: "1049",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedStatus = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selectedStatus == 1
                          ? Colors.orange
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "INACTIVE 21",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool selected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: selected ? Colors.orange.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: selected ? Colors.orange : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    categories[index]["title"],
                    style: TextStyle(
                      color: selected ? Colors.orange : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      categories[index]["count"].toString(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by Name, Email",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: "All Plans",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "All Plans",
                  child: Text("All Plans"),
                ),
                DropdownMenuItem(
                  value: "Enterprise",
                  child: Text("Enterprise"),
                ),
                DropdownMenuItem(
                  value: "Standard",
                  child: Text("Standard"),
                ),
              ],
              onChanged: (v) {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: "All",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                DropdownMenuItem(
                  value: "Active",
                  child: Text("Active"),
                ),
                DropdownMenuItem(
                  value: "Inactive",
                  child: Text("Inactive"),
                ),
              ],
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange.shade100,
                  child: Text(user.name[0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.status,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 24),
            infoRow("Email", user.email),
            infoRow("Type", user.type),
            infoRow("Phone", user.phone),
            infoRow("Plan", user.plan),
            infoRow("Signup", user.signupType),
            infoRow("Date", user.date),
          ],
        ),
      ),
    );
  }
}

class UserModel {
  final String name;
  final String email;
  final String type;
  final String phone;
  final String date;
  final String plan;
  final String signupType;
  final String status;

  UserModel({
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.date,
    required this.plan,
    required this.signupType,
    required this.status,
  });
}
