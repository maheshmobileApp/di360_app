import 'dart:convert';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatefulWidget {
  final List<PostImage>? postImage;
  final int? initialIndex;

  const ImageViewerScreen({
    required this.postImage,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen>
    with BaseContextHelpers {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
    _controller = PageController(initialPage: _currentIndex);
  }

  void _goToPage(int index) {
    if (index >= 0 && index < (widget.postImage?.length ?? 0)) {
      _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalImages = widget.postImage?.length ?? 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              physics: isScrollablePage(widget.postImage?[_currentIndex])
                  ? const PageScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: totalImages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                final media = widget.postImage?[index];
                return buildMediaContent(media);
              },
            ),
            if (totalImages > 1) ...[
              Positioned(
                left: 16,
                top: MediaQuery.of(context).size.height / 2 - 24,
                child: _currentIndex > 0
                    ? GestureDetector(
                        onTap: () => _goToPage(_currentIndex - 1),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.arrow_back_ios,
                              color: AppColors.whiteColor),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              Positioned(
                right: 16,
                top: MediaQuery.of(context).size.height / 2 - 24,
                child: _currentIndex < totalImages - 1
                    ? GestureDetector(
                        onTap: () => _goToPage(_currentIndex + 1),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.arrow_forward_ios,
                              color: AppColors.whiteColor),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () => navigationService.goBack(),
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.close, color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isScrollablePage(PostImage? media) {
    if (media == null) return true;
    final name = media.name?.toLowerCase() ?? '';
    final type = media.type ?? media.mimeType ?? '';

    if (name.endsWith('.pdf') || type == 'application/pdf') {
      return false;
    }
    if (name.endsWith('.doc') ||
        name.endsWith('.docx') ||
        type == 'application/msword') {
      return false;
    }
    return true;
  }

  Widget buildMediaContent(PostImage? media) {
    if (media == null) {
      return Center(child: Icon(Icons.broken_image, color: Colors.white));
    }

    final type = media.type ?? media.mimeType ?? '';
    final url = media.url ?? '';
    final name = media.name ?? '';

    bool isBase64Image(String data) => data.startsWith('data:image/');

    if (type.startsWith('image/') ||
        type.startsWith('application/octet-stream')) {
      if (isBase64Image(url)) {
        try {
          final decodedBytes = base64Decode(url.split(',').last);
          return Center(
            child: Image.memory(
              decodedBytes,
              fit: BoxFit.contain,
            ),
          );
        } catch (e) {
          return Center(child: Icon(Icons.broken_image, color: Colors.white));
        }
      } else if (name.toLowerCase().endsWith('.mp4')) {
        return InlineVideoPlayer(videoUrl: url);
      } else if (name.toLowerCase().endsWith('.pdf')) {
        return PdfViewrWidget(fileUrl: url, fileName: name);
      } else {
        return Center(
          child: CachedNetworkImageWidget(imageUrl: url),
        );
      }
    } else if (type == 'video/mp4') {
      return InlineVideoPlayer(videoUrl: url);
    } else if (type == 'application/pdf') {
      return PdfViewrWidget(fileUrl: url, fileName: name);
    } else if (type == 'application/msword') {
      return FileViewerScreen(fileUrl: url, fileName: name);
    } else {
      return Center(
        child: CachedNetworkImageWidget(imageUrl: url),
      );
    }
  }
}
