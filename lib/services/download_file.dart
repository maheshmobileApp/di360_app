import 'dart:io';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Directory> _getDownloadDir() async {
  if (Platform.isAndroid) {
    final dir = Directory('/storage/emulated/0/Download/DentalInterface360');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  } else {
    // iOS: saves to app Documents folder, accessible via Files app
    final dir = await getApplicationDocumentsDirectory();
    return dir;
  }
}

Future<bool> _requestPermission() async {
  if (Platform.isIOS) return true; // iOS needs no storage permission
  PermissionStatus status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return status.isGranted;
}

Future<void> downloadFile(BuildContext context, String url,
    {String? fileName}) async {
  try {
    if (!await _requestPermission()) {
      showTopMessage(context, "Storage permission denied");
      return;
    }

    showTopMessage(context, "Downloading file...");

    final String name =
        fileName?.isNotEmpty == true ? fileName! : url.split('/').last;
    final dir = await _getDownloadDir();
    final filePath = '${dir.path}/$name';

    final Dio dio = Dio();
    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );

    showTopMessage(context, "Download completed!");
    showTopMessage(context, "Downloaded to: $filePath");
    await OpenFile.open(filePath);
  } catch (e) {
    print("Download error: $e");
    // ignore: use_build_context_synchronously
    showTopMessage(context, "Download failed");
  }
}

Future<void> downloadAllFiles(
    BuildContext context, List<PostImage> mediaList) async {
  if (mediaList.isEmpty) return;

  if (!await _requestPermission()) {
    showTopMessage(context, "Storage permission denied");
    return;
  }

  showTopMessage(context, "Downloading ${mediaList.length} file(s)...");

  final dir = await _getDownloadDir();
  final Dio dio = Dio();

  await Future.wait(
    mediaList
        .where((media) => media.url?.isNotEmpty == true)
        .map((media) async {
      final name = media.name?.isNotEmpty == true
          ? media.name!
          : media.url!.split('/').last;
      final filePath = '${dir.path}/$name';
      try {
        await dio.download(media.url!, filePath);
        await OpenFile.open(filePath);
      } catch (e) {
        print('Failed to download ${media.name}: $e');
      }
    }),
  );

  // ignore: use_build_context_synchronously
  showTopMessage(context, "All downloads completed!");
}
