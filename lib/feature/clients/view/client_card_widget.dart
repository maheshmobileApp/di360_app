import 'package:di360_flutter/feature/clients/model_class/get_client_response.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Clients? client;

  const ClientCard({super.key, this.client});

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
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
                  child: Text(client?.name?.isNotEmpty ?? false
                      ? client!.name![0]
                      : ''),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    client?.name ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    client?.status ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const Divider(height: 24),
            infoRow("Email", client?.email ?? ''),
            infoRow("Type", client?.type ?? ''),
            infoRow("Phone", client?.phone ?? ''),
            infoRow("Plan", client?.subscriptionPlans?.name ?? ''),
            infoRow("Signup", client?.trackingDetails ?? ''),
            infoRow("Date", jiffyDataWidget(client?.createdAt, format: "yyyy-MM-dd hh:mm:ss a").toString())
          ],
        ),
      ),
    );
  }
}
