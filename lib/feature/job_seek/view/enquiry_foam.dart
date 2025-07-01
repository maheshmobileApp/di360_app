import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/widgets/closed_button_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnquiryForm extends StatefulWidget {
  const EnquiryForm({super.key});

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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CloseButtonWidget(
              onTap: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Enquiry",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(height: 16),
          InputTextField(
            onChange: (value) {
              final provider =
                  Provider.of<JobSeekViewModel>(context, listen: false);
              provider.onChangeEnquireData(value);
            },
            title: "Message",
            controller: _messageController,
            hintText: "Write Something...",
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
