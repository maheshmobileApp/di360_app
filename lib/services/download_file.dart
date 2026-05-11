import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/services/download_notification_service.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  if (Platform.isIOS) return true;
  if (Platform.isAndroid) {
    final info = await DeviceInfoPlugin().androidInfo;
    print('Android SDK version: ${info.version.sdkInt}');
    if (info.version.sdkInt >= 33) return true;
    final status = await Permission.storage.request();
    return status.isGranted;
  }
  return true;
}

Future<void> downloadFile(BuildContext context, String url,
    {String? fileName}) async {
  try {
    if (!await _requestPermission()) {
      showTopMessage(context, "Storage permission denied");
      return;
    }

    showTopMessage(context, "Downloading file...");

    final urlFileName = url.split('/').last;
    final ext =
        urlFileName.contains('.') ? '.${urlFileName.split('.').last}' : '';
    final baseName = fileName?.isNotEmpty == true ? fileName! : urlFileName;
    final String name = baseName.contains('.') ? baseName : '$baseName$ext';
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

    await DownloadNotificationService.showDownloadNotification(
      fileName: name,
      filePath: filePath,
    );
  } catch (e) {
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
      final urlFileName = media.url!.split('/').last;
      final ext =
          urlFileName.contains('.') ? '.${urlFileName.split('.').last}' : '';
      final baseName =
          media.name?.isNotEmpty == true ? media.name! : urlFileName;
      final name = baseName.contains('.') ? baseName : '$baseName$ext';
      final filePath = '${dir.path}/$name';
      try {
        await dio.download(media.url!, filePath);
        await DownloadNotificationService.showDownloadNotification(
          fileName: "${name} file",
          filePath: filePath,
        );
      } catch (e) {
        print('Failed to download ${media.name}: $e');
      }
    }),
  );
}
