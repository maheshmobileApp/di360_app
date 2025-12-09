import 'dart:io';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String userName;
  final String ticketNo;
  final String dateTime; // display string e.g. "12 Nov 2025 · 11:45pm"
  final String reason;
  final double borderRadius;
  final VoidCallback? onTap;

  const TicketCard({
    Key? key,
    required this.userName,
    required this.ticketNo,
    required this.dateTime,
    required this.reason,
    this.borderRadius = 16.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ticket No : $ticketNo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Date chip
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    dateTime,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Divider(color: Colors.grey[300], thickness: 1),
            SizedBox(height: 2),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              
              Expanded(
                child: Text(
                  "Reason : $reason",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

// Example main to preview the card
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF6F8FA),
        appBar: AppBar(title: Text('Ticket Card Demo')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TicketCard(
                userName: 'User Name',
                ticketNo: 'DS21000',
                dateTime: '12 Nov 2025 · 11:45pm',
                reason:
                    'offering a wide range of general dentistry services, with a specialization in dental implants. The services provided include...',
                onTap: () {},
              ),

              SizedBox(height: 20),

              // optional: show the uploaded image (screenshot) below the card so you can compare
              Builder(builder: (context) {
                final file = File('/mnt/data/2e163c81-2ef5-4674-9be6-5e73f692b1e9.png');
                if (!file.existsSync()) return SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text('Reference screenshot:'),
                    SizedBox(height: 8),
                    Image.file(file, height: 120),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}