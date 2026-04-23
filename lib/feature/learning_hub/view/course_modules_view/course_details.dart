import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
// your existing player

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late final ScrollController _moduleScrollController;

  @override
  void initState() {
    super.initState();
    _moduleScrollController = ScrollController();
  }

  @override
  void dispose() {
    _moduleScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course")),
      body: Consumer<CourseListingViewModel>(
        builder: (context, provider, _) {
          if (provider.courseDetails == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final section = provider.currentSection;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(provider.courseDetails?.courseName ?? ''),
                _moduleSection(provider),
                _videoCard(provider, section),
                _description(section),
                _images(section),
                _quizSection(),
                _downloadSection(section),
                _completeButton(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 🔹 HEADER
  Widget _headerCard(String title) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(width: 4, height: 40, color: AppColors.primaryColor),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("A Comprehensive Guide",
                  style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  /// 🔹 MODULE SECTION — list of modules + prev/next nav
  Widget _moduleSection(CourseListingViewModel provider) {
    final modules = provider.courseDetails?.moduleSection ?? [];
    if (modules.isEmpty) return const SizedBox();

    final isFirst = provider.currentModuleIndex == 0;
    final isLast = provider.currentModuleIndex == modules.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: modules.length,
            itemBuilder: (_, i) {
              final isActive = i == provider.currentModuleIndex;
              return GestureDetector(
                onTap: () => provider.setCurrent(i, 0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primaryColor : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isActive ? AppColors.primaryColor : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    modules[i].moduleName ?? "Module ${i + 1}",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.black87,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          // Current section topic
          Text(
            provider.currentSection.courseTopic?.toUpperCase() ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          // Prev / Next buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: isFirst ? null : provider.goToPrevious,
                child: Row(children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isFirst ? Colors.grey.shade300 : Colors.orange,
                    child: Icon(Icons.arrow_back, color: isFirst ? Colors.grey : Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text("PREVIOUS",
                      style: TextStyle(color: isFirst ? Colors.grey : Colors.black87)),
                ]),
              ),
              GestureDetector(
                onTap: isLast ? null : provider.markCompleteAndNext,
                child: Row(children: [
                  Text("NEXT",
                      style: TextStyle(color: isLast ? Colors.grey : Colors.black87)),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isLast ? Colors.grey.shade300 : Colors.orange,
                    child: Icon(Icons.arrow_forward, color: isLast ? Colors.grey : Colors.white, size: 16),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 VIDEO
  Widget _videoCard(CourseListingViewModel provider, section) {
    if (section.youtubeLink == null || section.youtubeLink.isEmpty) {
      return const SizedBox();
    }

    final modules = provider.courseDetails?.moduleSection ?? [];
    final isFirst = provider.currentModuleIndex == 0;
    final isLast = provider.currentModuleIndex == modules.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: LazyYoutubePlayer(youtubeUrl: section.youtubeLink),
            ),
          ),
          const SizedBox(height: 10),
          // Two stacked buttons below video
          GestureDetector(
            onTap: isFirst ? null : provider.goToPrevious,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isFirst ? Colors.grey.shade200 : Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 16,
                      color: isFirst ? Colors.grey : Colors.white),
                  const SizedBox(width: 8),
                  Text("PREVIOUS MODULE",
                      style: TextStyle(
                          color: isFirst ? Colors.grey : Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: isLast ? null : provider.markCompleteAndNext,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isLast ? Colors.grey.shade200 : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NEXT MODULE",
                      style: TextStyle(
                          color: isLast ? Colors.grey : Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16,
                      color: isLast ? Colors.grey : Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 DESCRIPTION (HTML)
  Widget _description(section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HtmlWidget(section.description ?? ''),
    );
  }

  /// 🔹 IMAGES
  Widget _images(section) {
    if (section.image == null || section.image.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: section.image.length,
          itemBuilder: (_, i) {
            final img = section.image[i];
            final url = img.url ?? '';

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  url,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 🔹 QUIZ BUTTON
  Widget _quizSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "PERSONALISE YOUR LEARNING JOURNEY",
          style: TextStyle(letterSpacing: 1, fontSize: 12),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Text("TAKE A QUIZ", style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.orange,
              child: Icon(Icons.arrow_forward, size: 14),
            )
          ]),
        )
      ]),
    );
  }

  /// 🔹 DOWNLOAD
  Widget _downloadSection(section) {
    if (section.attachment == null) return const SizedBox();

    final attachment = section.attachment;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 4, height: 30, color: Colors.orange),
          const SizedBox(width: 10),
          const Text("Lesson Downloads", style: TextStyle(fontSize: 16)),
          const Spacer(),
          const CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.list, color: Colors.white),
          )
        ]),
        const Divider(height: 20),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.picture_as_pdf),
          title: Text(
            attachment.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "PDF • ${(attachment.size ?? 0) ~/ 1000000} MB",
          ),
          onTap: () {
            // open/download PDF
          },
        )
      ]),
    );
  }

  /// 🔹 COMPLETE BUTTON
  Widget _completeButton(CourseListingViewModel provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: provider.markCompleteAndNext,
          child: const Text("Complete & Continue"),
        ),
      ),
    );
  }

  /// 🔹 CIRCLE BUTTON
  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.orange,
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }
}
