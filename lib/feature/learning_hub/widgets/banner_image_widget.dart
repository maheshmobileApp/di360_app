import 'package:flutter/material.dart';

class BannerImageWidget extends StatelessWidget {
  final String imageUrl;

  const BannerImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 180,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, size: 50, color: Colors.red);
      },
    );
  }
}
