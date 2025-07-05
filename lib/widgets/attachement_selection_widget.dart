import 'package:flutter/material.dart';

void imagePickerSelection(
    BuildContext context, Function()? galleryOnTap, Function()? cameraOnTap) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: galleryOnTap,
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: cameraOnTap,
            ),
          ],
        );
      });
}
