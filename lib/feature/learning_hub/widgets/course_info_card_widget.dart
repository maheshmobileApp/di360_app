import 'package:flutter/material.dart';

class CourseInfoCardWidget extends StatelessWidget {
  final String courseName;
  final String presentByName;
  final String cpdHours;
  final String platform;
  final String webinar;

  const CourseInfoCardWidget(
      {super.key,
      required this.courseName,
      required this.presentByName,
      required this.cpdHours,
      required this.platform,
      required this.webinar});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${courseName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("A Comprehensive Guide",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${presentByName}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("A Comprehensive Guide",
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTextWidget(
                    label: "CPD Duration",
                    value: "${cpdHours}",
                    color: Colors.red),
                _InfoTextWidget(
                    label: "Platform",
                    value: "${platform}",
                    color: Colors.orange),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTextWidget(
                    label: "Webinar", value: "${webinar}", color: Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("\$399.00",
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),
                    Text("AUD \$299.00",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTextWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoTextWidget({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
