import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/widgets/closed_button_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnquiryForm extends StatefulWidget {
  EnquiryForm({
    super.key,
    required this.onChange,
  });
  Function(String onchageValue) onChange;

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButtonWidget(
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text(
              "Enquiry",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            InputTextField(
              onChange: (value) {
                widget.onChange(value);
              },
              title: "",
              controller: _messageController,
              hintText: "Write Something...",
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
