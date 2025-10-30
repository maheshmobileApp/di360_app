import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/widgets/network_video_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImagePickerField extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final double borderRadius;
  final String? hintText;
  final bool showPreview;
  final bool allowMultiple;

  // Local Single file
  final File? selectedFile;
  final ValueChanged<File?>? onFilePicked;

  // Local Multiple files
  final List<File>? selectedFiles;
  final ValueChanged<List<File>>? onFilesPicked;

  // Server Images
  final String? serverImage;
  final String? serverImageType;
  final List<String>? serverImages;

  final ValueChanged<String?>? onServerFileRemoved;
  final ValueChanged<List<String>>? onServerFilesRemoved;

  const ImagePickerField({
    super.key,
    this.title,
    this.isRequired = false,
    this.borderRadius = 8.0,
    this.hintText,
    this.showPreview = true,
    this.allowMultiple = false,
    this.selectedFile,
    this.onFilePicked,
    this.selectedFiles,
    this.onFilesPicked,
    this.serverImage,
    this.serverImages,
    this.serverImageType,
    this.onServerFileRemoved,
    this.onServerFilesRemoved,
  });

  void _showPickerSheet(
      BuildContext context, FormFieldState<List<dynamic>> field) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                    icon: Icons.photo_library,
                    label: "Gallery",
                    color: Colors.blue,
                    onTap: () => _pickFile(context, ImageSource.gallery, field),
                  ),
                  _buildOption(
                    icon: Icons.camera_alt,
                    label: "Camera",
                    color: Colors.green,
                    onTap: () => _pickFile(context, ImageSource.camera, field),
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

  Future<void> _pickFile(BuildContext context, ImageSource source,
      FormFieldState<List<dynamic>> field) async {
    final picker = ImagePicker();

    if (allowMultiple) {
      List<File> newFiles = [];

      if (source == ImageSource.gallery) {
        final pickedList = await picker.pickMultiImage(imageQuality: 80);
        if (pickedList != null && pickedList.isNotEmpty) {
          newFiles = pickedList.map((e) => File(e.path)).toList();
        }
      } else {
        final picked = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 80);
        if (picked != null) newFiles.add(File(picked.path));
      }

      if (newFiles.isNotEmpty) {
        final merged = <File>[
          if (selectedFiles != null) ...selectedFiles!,
          ...newFiles,
        ];
        onFilesPicked?.call(merged);

        // ✅ Update FormField value to remove validation error
        field.didChange([
          if (selectedFile != null) selectedFile!,
          ...merged,
          if (serverImages != null) ...serverImages!,
        ]);
        field.validate();
      }
    } else {
      XFile? picked;
      if (source == ImageSource.camera) {
        picked = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 80);
      } else {
        picked = await picker.pickMedia(imageQuality: 80);
      }

      if (picked != null) {
        final file = File(picked.path);
        onFilePicked?.call(file);

        // ✅ Update FormField value
        field.didChange([
          file,
          if (selectedFiles != null) ...selectedFiles!,
          if (serverImages != null) ...serverImages!,
        ]);

        // ✅ Trigger validation immediately
        field.validate();
      }
    }

    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: [
        if (selectedFile != null) selectedFile!,
        if (selectedFiles != null) ...selectedFiles!,
        if (serverImage != null) serverImage!,
        if (serverImages != null) ...serverImages!,
      ],
      validator: (files) {
        if (isRequired && (files == null || files.isEmpty)) {
          return "Please upload ${title ?? "file"}";
        }
        return null;
      },
      builder: (field) {
        final hasSingleFile = selectedFile != null;
        final hasMultipleFiles =
            selectedFiles != null && selectedFiles!.isNotEmpty;
        final hasServerSingle = serverImage != null && serverImage!.isNotEmpty;
        final hasServerMultiple =
            serverImages != null && serverImages!.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Row(
                children: [
                  Text(title!,
                      style: TextStyles.regular3(color: AppColors.black)),
                  if (isRequired)
                    const Text(' *',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            const SizedBox(height: 10),
            GestureDetector(
              //onTap: () => _showPickerSheet(context, field),
              onTap: (selectedFile == null &&
                      (selectedFiles == null || selectedFiles!.isEmpty) &&
                      (serverImage == null || serverImage!.isEmpty) &&
                      (serverImages == null || serverImages!.isEmpty))
                  ? () => _showPickerSheet(context, field)
                  : null,
              child: DottedBorder(
                color: field.hasError ? Colors.red : Colors.grey.shade400,
                strokeWidth: 1.5,
                dashPattern: const [6, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular(borderRadius),
                child: Container(
                  width: double.infinity,
                  height: showPreview ? 150 : null,
                  alignment: Alignment.center,
                  child: (hasServerMultiple || hasMultipleFiles)
                      ? _buildCombinedFiles(context, field)
                      : hasSingleFile
                          ? _buildLocalSingleFile(field)
                          : hasServerSingle
                              ? _buildServerSingleFile(field)
                              : _buildPlaceholder(),
                ),
              ),
            ),
            if (field.hasError) ...[
              const SizedBox(height: 5),
              Text(field.errorText ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 12))
            ]
          ],
        );
      },
    );
  }

  Widget _buildLocalSingleFile(FormFieldState<List<dynamic>> field) => Stack(
        children: [
          Builder(
            builder: (_) {
              if (selectedFile!.path.toLowerCase().endsWith(".mp4")) {
                return FutureBuilder<String?>(
                  future: VideoThumbnail.thumbnailFile(
                      video: selectedFile!.path,
                      imageFormat: ImageFormat.JPEG,
                      maxHeight: 150,
                      quality: 75),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Image.file(File(snapshot.data!),
                          fit: BoxFit.cover);
                    }
                    return const Center(
                        child:
                            Icon(Icons.videocam, size: 50, color: Colors.grey));
                  },
                );
              }
              return Image.file(selectedFile!,
                  fit: BoxFit.contain, width: double.infinity);
            },
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                onFilePicked?.call(null);
                field.didChange([
                  if (selectedFiles != null) ...selectedFiles!,
                  if (serverImage != null) serverImage!,
                  if (serverImages != null) ...serverImages!,
                ]);

                // ✅ Trigger validation immediately
                field.validate();
              },
              child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white, size: 16)),
            ),
          ),
        ],
      );

  Widget _buildServerSingleFile(FormFieldState<List<dynamic>> field) => Stack(
        children: [
          serverImageType != "image"
              ? NetworkVideoWidget(url: serverImage!)
              : Image.network(serverImage!,
                  fit: BoxFit.contain, width: double.infinity),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                onServerFileRemoved?.call(null);
                field.didChange([
                  if (selectedFile != null) selectedFile!,
                  if (selectedFiles != null) ...selectedFiles!,
                  if (serverImages != null) ...serverImages!,
                ]);
              },
              child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white, size: 16)),
            ),
          ),
        ],
      );

  Widget _buildCombinedFiles(
      BuildContext context, FormFieldState<List<dynamic>> field) {
    final serverCount = serverImages?.length ?? 0;
    final localCount = selectedFiles?.length ?? 0;
    final totalItems = serverCount + localCount + 1;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: totalItems,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, index) {
        if (index < serverCount) {
          final url = serverImages![index];
          final isVideo = url.toLowerCase().endsWith(".mp4");
          return Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isVideo
                      ? const Icon(Icons.videocam, size: 50, color: Colors.grey)
                      : Image.network(url, fit: BoxFit.contain)),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    final newList = List<String>.from(serverImages!);
                    newList.removeAt(index);
                    onServerFilesRemoved?.call(newList);
                    field.didChange([
                      if (selectedFile != null) selectedFile!,
                      if (selectedFiles != null) ...selectedFiles!,
                      ...newList,
                    ]);
                    field.validate();
                  },
                  child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, color: Colors.white, size: 14)),
                ),
              ),
            ],
          );
        } else if (index < serverCount + localCount) {
          final localIndex = index - serverCount;
          final file = selectedFiles![localIndex];
          final isVideo = file.path.toLowerCase().endsWith(".mp4");
          return Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isVideo
                      ? FutureBuilder<String?>(
                          future: VideoThumbnail.thumbnailFile(
                              video: file.path,
                              imageFormat: ImageFormat.JPEG,
                              maxHeight: 150,
                              quality: 75),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Image.file(File(snapshot.data!),
                                  fit: BoxFit.cover);
                            }
                            return const Center(
                                child: Icon(Icons.videocam,
                                    size: 50, color: Colors.grey));
                          },
                        )
                      : Image.file(file, fit: BoxFit.contain)),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    final newList = List<File>.from(selectedFiles!);
                    newList.removeAt(localIndex);
                    onFilesPicked?.call(newList);
                    field.didChange([
                      if (selectedFile != null) selectedFile!,
                      ...newList,
                      if (serverImages != null) ...serverImages!,
                    ]);
                  },
                  child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, color: Colors.white, size: 14)),
                ),
              ),
            ],
          );
        } else {
          return _buildAddItemCard(() => _showPickerSheet(context, field));
        }
      },
    );
  }

  Widget _buildPlaceholder() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageConst.upload),
          const SizedBox(height: 20),
          Text("Click here to Choose a file.",
              style: TextStyles.medium2(color: AppColors.black)),
          const SizedBox(height: 8),
          Text(hintText ?? "JPEG, PNG formats, up to 5 MB each",
              style: TextStyles.regular2(color: AppColors.dropDownHint)),
        ],
      );

  Widget _buildAddItemCard(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid,
                  width: 1.2),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageConst.upload),
                const SizedBox(height: 8),
                const Text(
                  "Add Item",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      );
}
