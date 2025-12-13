import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:flutter/material.dart';


class EnquiriesListView extends StatelessWidget with BaseContextHelpers {
  final ApplicantEnquiryData? applicant;
  final String? profileImageUrl;

  const EnquiriesListView({super.key, required this.applicant, this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Enquiry",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),

                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (applicant?.jobEnquiries != null)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: applicant?.jobEnquiries!.length,
                            itemBuilder: (context, index) {
                              

                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundImage: profileImageUrl!=
                                          null
                                      ? NetworkImage(profileImageUrl!)
                                      : null,
                                  child: profileImageUrl ==
                                          null
                                      ? const Icon(Icons.person, size: 24)
                                      : null,
                                ),
                                title: Text(applicant?.jobEnquiries?[index].enquiryDescription??""),
                              );
                            },
                          )
                        else
                          const Text("No enquiries found"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
