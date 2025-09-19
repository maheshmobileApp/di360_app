import 'package:flutter/material.dart';

class CourseDescriptionWidget extends StatelessWidget {
  const CourseDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
              "STEPWISE GUIDE TO A CONSERVATIVE AESTHETIC OPTION FOR YOUR PATIENTS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(height: 8),
          Text(
            "Develop confidence in designing and delivering a conservative aesthetic option for patients. "
            "Dr Shepperson will walk through every aspect of veneer delivery, from initial risk assessment, "
            "material selection and treatment steps.",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
