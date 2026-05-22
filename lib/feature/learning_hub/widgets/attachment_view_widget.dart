import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> attachments;
  final String? title;

  const AttachmentViewWidget({
    Key? key,
    required this.attachments,
    this.title = 'Attachments',
  }) : super(key: key);

  IconData _iconForType(String? type) {
    if (type == null) return Icons.insert_drive_file;
    final t = type.toLowerCase();
    if (t.contains('pdf')) return Icons.picture_as_pdf;
    if (t.contains('image') || t.contains('png') || t.contains('jpg'))
      return Icons.image;
    if (t.contains('video')) return Icons.videocam;
    if (t.contains('word') || t.contains('doc')) return Icons.description;
    if (t.contains('excel') || t.contains('sheet') || t.contains('xls'))
      return Icons.table_chart;
    return Icons.insert_drive_file;
  }

  Color _colorForType(String? type) {
    if (type == null) return AppColors.geryColor;
    final t = type.toLowerCase();
    if (t.contains('pdf')) return Colors.red;
    if (t.contains('image') || t.contains('png') || t.contains('jpg'))
      return AppColors.blueColor;
    if (t.contains('video')) return Colors.purple;
    if (t.contains('word') || t.contains('doc')) return Colors.blue;
    if (t.contains('excel') || t.contains('sheet') || t.contains('xls'))
      return Colors.green;
    return AppColors.geryColor;
  }

  Future<void> _openAttachment(
      BuildContext context, Map<String, dynamic> attachment) async {
    final url = attachment['url']?.toString() ?? '';
    final name = attachment['name']?.toString() ?? 'file';
    if (url.isEmpty) return;

    final notifier = ValueNotifier<double>(0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ValueListenableBuilder<double>(
        valueListenable: notifier,
        builder: (_, progress, __) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Downloading...'),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                  value: progress, color: AppColors.primaryColor),
              const SizedBox(height: 8),
              Text('${(progress * 100).toStringAsFixed(0)}%'),
            ],
          ),
        ),
      ),
    );

    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/$name';
      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) notifier.value = received / total;
        },
      );
      if (context.mounted) Navigator.of(context).pop();
      await OpenFile.open(filePath);
    } catch (_) {
      if (context.mounted) Navigator.of(context).pop();
    } finally {
      notifier.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          Text(title!, style: TextStyles.bold2(color: AppColors.primaryColor)),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: attachments.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = attachments[index];
              final name = item['name']?.toString() ?? 'File ${index + 1}';
              final type = item['type']?.toString();
              final color = _colorForType(type);
              return GestureDetector(
                onTap: () => _openAttachment(context, item),
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageConst.pdf, width: 36, height: 36),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: TextStyles.regular1(color: AppColors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
