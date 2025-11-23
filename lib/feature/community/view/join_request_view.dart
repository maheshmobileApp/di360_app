import 'package:di360_flutter/feature/community/widgets/join_request_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class JoinRequestView extends StatelessWidget {
  final List<Map<String, String>> joinRequests = [
    {
      'name': 'Dr. John Smith',
      'email': 'john.smith@email.com',
      'profession': 'Dental Surgeon',
      'experience': '5 years',
      'date': '2 days ago'
    },
    {
      'name': 'Dr. Sarah Johnson',
      'email': 'sarah.j@email.com',
      'profession': 'Orthodontist',
      'experience': '8 years',
      'date': '1 week ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Join Requests"),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: joinRequests.length,
        itemBuilder: (context, index) {
          return JoinRequestCard(
            firstName: "Nani",
            lastName: "Teppala",
            email: "nani@gmail.com",
            phone: "9876543210",
            status: "Pending",
            membership: "Gold",
            onApprove: () {
              print("Approved");
            },
            onReject: () {
              print("Rejected");
            },
          );
        },
      ),
    );
  }
}
