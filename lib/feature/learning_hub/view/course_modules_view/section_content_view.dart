import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionContentView extends StatelessWidget {
  const SectionContentView({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<CourseListingViewModel>(
      builder: (context, provider, _) {
        final section = provider.currentSection;

        return SingleChildScrollView(
          child: Column(
          children: [
            /// VIDEO
            if (section.youtubeLink != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: LazyYoutubePlayer(youtubeUrl: section.youtubeLink!),
              ),

            /// DESCRIPTION
            Padding(
                padding: const EdgeInsets.all(12),
                child: Text(section.description ?? '')),

            /// IMAGES
            if (section.image != null)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: section.image!.length,
                  itemBuilder: (_, i) {
                    final img = section.image![i];
                    final url = (img is Map) ? img['url']?.toString() ?? '' : img.toString();
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: url.isNotEmpty ? Image.network(url) : const SizedBox.shrink(),
                    );
                  },
                ),
              ),

            /// ATTACHMENT
            if (section.attachment != null)
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text((section.attachment is Map)
                    ? (section.attachment as Map)['name']?.toString() ?? ''
                    : section.attachment.toString()),
              ),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  provider.markCompleteAndNext();
                },
                child: Text("Complete & Continue"),
              ),
            )
          ],
        ));

      },
    );
  }
}
