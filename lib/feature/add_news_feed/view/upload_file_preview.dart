import 'dart:convert';
import 'dart:io';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FileUploadWidget extends StatefulWidget {
  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  final ImagePicker _imagePicker = ImagePicker();

  void _showSourcePicker(AddNewsFeedViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Choose Option",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                    icon: Icons.camera_alt,
                    label: "Camera",
                    color: Colors.blue,
                    onTap: () async {
                      Navigator.pop(context);
                      final picked = await _imagePicker.pickImage(
                          source: ImageSource.camera, imageQuality: 85);
                      if (picked != null) viewModel.addFiles([picked]);
                    },
                  ),
                  _buildOption(
                    icon: Icons.photo_library,
                    label: "Gallery",
                    color: Colors.orange,
                    onTap: () async {
                      Navigator.pop(context);
                      final List<XFile> picked =
                          await _imagePicker.pickMultiImage(imageQuality: 85);
                      if (picked.isNotEmpty) viewModel.addFiles(picked);
                    },
                  ),
                  _buildOption(
                    icon: Icons.file_copy_rounded,
                    label: "Files",
                    color: Colors.green,
                    onTap: () async {
                      Navigator.pop(context);
                      final result = await FilePicker.platform
                          .pickFiles(allowMultiple: true, type: FileType.any);
                      if (result != null) {
                        final xFiles = result.files
                            .where((f) => f.path != null)
                            .map((f) => XFile(f.path!))
                            .toList();
                        viewModel.addFiles(xFiles);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
          {required IconData icon,
          required String label,
          required Color color,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
          ],
        ),
      );

  Widget _fileCard(Widget child, int index, AddNewsFeedViewModel viewModel,
      {bool isExisting = false}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              if (isExisting) {
                viewModel.removeExistingFile(index);
              } else {
                viewModel.removeFile(index);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFilePreview(
      XFile file, int index, AddNewsFeedViewModel viewModel) {
    final extension = file.path.split('.').last.toLowerCase();

    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      return _fileCard(
          Image.file(File(file.path), fit: BoxFit.cover), index, viewModel);
    } else if (extension == 'pdf') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else if (['mp4', 'mov', 'avi'].contains(extension)) {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  color: Colors.black12,
                  child: Icon(Icons.videocam, size: 40, color: Colors.purple)),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.purple,
                  child: Text('Video',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else {
      return _fileCard(
          Icon(Icons.insert_drive_file, size: 40), index, viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddNewsFeedViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload File", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showSourcePicker(viewModel),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.attach_file, size: 30),
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          children: [
            ...List.generate(
              viewModel.existingImages.length,
              (index) => _buildExistingImagePreview(
                  viewModel.existingImages[index], index, viewModel),
            ),
            ...List.generate(
              viewModel.selectedFiles.length,
              (index) => _buildFilePreview(
                  viewModel.selectedFiles[index], index, viewModel),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildExistingImagePreview(
      PostImage image, int index, AddNewsFeedViewModel viewModel) {
    final type = image.type ?? image.mimeType ?? '';
    final url = image.url ?? '';

    // Helper: check if base64
    bool isBase64Image(String data) => data.startsWith('data:image/');

    if (type.startsWith('image/') ||
        type.startsWith('application/octet-stream')) {
      if (isBase64Image(url)) {
        try {
          final decodedBytes = base64Decode(url.split(',').last);
          return _fileCard(
              Image.memory(decodedBytes, fit: BoxFit.cover), index, viewModel,
              isExisting: true);
        } catch (e) {
          return Icon(Icons.broken_image);
        }
      } else if (image.name!.endsWith('.mp4')) {
        return _fileCard(
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    color: Colors.black12,
                    child:
                        Icon(Icons.videocam, size: 40, color: Colors.purple)),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: Colors.purple,
                    child: Text('Video',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                )
              ],
            ),
            index,
            viewModel);
      } else {
        return _fileCard(
            Image.network(url, fit: BoxFit.cover), index, viewModel,
            isExisting: true);
      }
    } else if (type == 'video/mp4') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  color: Colors.black12,
                  child: Icon(Icons.videocam, size: 40, color: Colors.purple)),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.purple,
                  child: Text('Video',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else if (type == 'application/pdf') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else if (type == 'application/msword') {
      return _fileCard(
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.picture_as_pdf, size: 40, color: Colors.red),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Colors.red,
                  child: Text('PDF',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              )
            ],
          ),
          index,
          viewModel);
    } else {
      return _fileCard(Image.network(url, fit: BoxFit.cover), index, viewModel,
          isExisting: true);
    }
  }
  // return _fileCard(
  //     Image.network(image.url ?? '', fit: BoxFit.cover), index, viewModel,
  //     isExisting: true);
}
