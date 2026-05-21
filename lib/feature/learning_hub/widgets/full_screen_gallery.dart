import 'package:flutter/material.dart';

class FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final Widget Function(String imageUrl) imageBuilder;

  const FullScreenGallery({
    Key? key,
    required this.images,
    required this.initialIndex,
    required this.imageBuilder,
  }) : super(key: key);

  static Future<void> open({
    required BuildContext context,
    required List<String> images,
    int initialIndex = 0,
    required Widget Function(String imageUrl) imageBuilder,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenGallery(
          images: images,
          initialIndex: initialIndex,
          imageBuilder: imageBuilder,
        ),
      ),
    );
  }

  @override
  State<FullScreenGallery> createState() =>
      _FullScreenGalleryState();
}

class _FullScreenGalleryState
    extends State<FullScreenGallery> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: widget.imageBuilder(
                    widget.images[index],
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}