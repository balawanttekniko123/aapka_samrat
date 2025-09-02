import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';



class HelperFunctions {

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: '+91$phoneNumber');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $uri');
      }
    } catch (e) {
      print('Error making phone call: $e');
    }
  }
  static Future<void> launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Your Subject',
        'body': 'Hello, I would like to...',
      },
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $uri');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }
  static Future<void> launchExternalUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }



  Future<void> downloadImagesWithHttp(BuildContext context, List<String> urls) async {
    // Ask for permission
    PermissionStatus status = await Permission.storage.request();

    // if (!status.isGranted) {
    //   bool isPermanentlyDenied = status.isPermanentlyDenied;
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: const Text("Storage permission not granted. Cannot download images."),
    //       action: isPermanentlyDenied
    //           ? SnackBarAction(
    //         label: "Settings",
    //         onPressed: () async {
    //           await openAppSettings();
    //         },
    //       )
    //           : null,
    //       duration: const Duration(seconds: 4),
    //     ),
    //   );
    //   return;
    // }

    Directory? directory;

    // Handle Android 11+ with scoped storage
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted ||
          await Permission.storage.isGranted) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getExternalStorageDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot access download directory.")),
      );
      return;
    }

    // Ensure the folder exists
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    for (final url in urls) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final fileName = path.basename(url);
          final filePath = path.join(directory.path, fileName);
          final file = File(filePath);

          await file.writeAsBytes(response.bodyBytes);
          print("Downloaded: $fileName");

          // Show snackbar with open action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$fileName downloaded'),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () => OpenFile.open(filePath),
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to download $url')),
          );
        }
      } catch (e) {
        print("Error downloading $url: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error downloading image')),
        );
      }
    }
  }

  static String formatDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('d MMMM yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}

