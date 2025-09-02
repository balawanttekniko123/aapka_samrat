// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
//
// class FullScreenGalleryScreen extends StatelessWidget {
//   final List<String> imageUrls;
//   final int initialIndex;
//
//   const FullScreenGalleryScreen({
//     Key? key,
//     required this.imageUrls,
//     this.initialIndex = 0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController(initialPage: initialIndex);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: PhotoViewGallery.builder(
//         itemCount: imageUrls.length,
//         pageController: pageController,
//         builder: (context, index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: NetworkImage(imageUrls[index]),
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 2,
//           );
//         },
//         scrollPhysics: const BouncingScrollPhysics(),
//         backgroundDecoration: BoxDecoration(color: Colors.black),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';
//
// class FullScreenGalleryScreen extends StatelessWidget {
//   final List<String> imageUrls;
//   final int initialIndex;
//
//   const FullScreenGalleryScreen({
//     Key? key,
//     required this.imageUrls,
//     this.initialIndex = 0,
//   }) : super(key: key);
//
//   // Function to download the image to a temporary directory and return the file path
//   Future<String?> _downloadImageToTemp(String url, BuildContext context) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final tempDir = await getTemporaryDirectory();
//         final filePath = '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         return filePath;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to download image')),
//         );
//         return null;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error downloading image: $e')),
//       );
//       return null;
//     }
//   }
//
//   // Function to save the image to a public storage directory (e.g., Pictures)
//   Future<void> _downloadImage(String url, BuildContext context) async {
//     try {
//       // Request storage permission
//       var status = Platform.isAndroid
//           ? await Permission.storage.request()
//           : await Permission.photos.request();
//       if (status.isGranted) {
//         final response = await http.get(Uri.parse(url));
//         if (response.statusCode == 200) {
//           // Use a public directory like Pictures
//           final directory = await getExternalStorageDirectory();
//           final picturesDir = Directory('${directory!.parent.path}/Pictures');
//           if (!await picturesDir.exists()) {
//             await picturesDir.create(recursive: true);
//           }
//           final filePath = '${picturesDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
//           final file = File(filePath);
//           await file.writeAsBytes(response.bodyBytes);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Image saved to $filePath')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to download image')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Storage permission denied')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving image: $e')),
//       );
//     }
//   }
//
//   // Function to share the image file
//   Future<void> _shareImage(String url, BuildContext context) async {
//     try {
//       final filePath = await _downloadImageToTemp(url, context);
//       if (filePath != null) {
//         await Share.shareXFiles([XFile(filePath)], text: 'Check out this image!');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sharing image: $e')),
//       );
//     }
//   }
//
//   // Show bottom sheet with options
//   void _showContextMenu(BuildContext context, String imageUrl) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.download),
//                 title: Text('Download'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _downloadImage(imageUrl, context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.share),
//                 title: Text('Share'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _shareImage(imageUrl, context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController(initialPage: initialIndex);
//     ValueNotifier<int> currentIndex = ValueNotifier<int>(initialIndex);
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: GestureDetector(
//         onLongPress: () {
//           _showContextMenu(context, imageUrls[currentIndex.value]);
//         },
//         child: PhotoViewGallery.builder(
//           itemCount: imageUrls.length,
//           pageController: pageController,
//           builder: (context, index) {
//             return PhotoViewGalleryPageOptions(
//               imageProvider: NetworkImage(imageUrls[index]),
//               minScale: PhotoViewComputedScale.contained,
//               maxScale: PhotoViewComputedScale.covered * 2,
//             );
//           },
//           scrollPhysics: const BouncingScrollPhysics(),
//           backgroundDecoration: BoxDecoration(color: Colors.black),
//           onPageChanged: (index) {
//             currentIndex.value = index; // Update current index on page change
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class FullScreenGalleryScreen extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  FullScreenGalleryScreen({
    Key? key,
    required this.imageUrls,
    this.initialIndex = 0,
  }) : super(key: key);

  // Function to download the image to a temporary directory and return the file path
  Future<String?> _downloadImageToTemp(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Failed to download image')),
        );
        return null;
      }
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Error downloading image: $e')),
      );
      return null;
    }
  }

  // Function to save the image to a public storage directory (e.g., Pictures)
  // Function to save the image to a public storage directory (e.g., Pictures)
  // Future<void> _downloadImage(String url) async {
  //   try {
  //     // Request appropriate permissions
  //     bool permissionGranted = false;
  //     if (Platform.isAndroid) {
  //       // For Android 13+, try Permission.photos first
  //       var status = await Permission.photos.request();
  //       if (status.isGranted) {
  //         permissionGranted = true;
  //       } else {
  //         // Fallback to Permission.storage for older Android versions
  //         status = await Permission.storage.request();
  //         if (status.isGranted) {
  //           permissionGranted = true;
  //         }
  //       }
  //     } else if (Platform.isIOS) {
  //       var status = await Permission.photos.request();
  //       permissionGranted = status.isGranted;
  //     }
  //
  //     if (permissionGranted) {
  //       final response = await http.get(Uri.parse(url));
  //       if (response.statusCode == 200) {
  //         // Use a public directory like Pictures
  //         final directory = await getExternalStorageDirectory();
  //         final picturesDir = Directory('${directory!.parent.path}/Pictures');
  //         if (!await picturesDir.exists()) {
  //           await picturesDir.create(recursive: true);
  //         }
  //         final filePath = '${picturesDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //         final file = File(filePath);
  //         await file.writeAsBytes(response.bodyBytes);
  //         _scaffoldMessengerKey.currentState?.showSnackBar(
  //           SnackBar(content: Text('Image saved to $filePath')),
  //         );
  //       } else {
  //         _scaffoldMessengerKey.currentState?.showSnackBar(
  //           SnackBar(content: Text('Failed to download image')),
  //         );
  //       }
  //     } else {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(
  //           content: Text('Storage permission denied. Please grant permission in settings.'),
  //           action: SnackBarAction(
  //             label: 'Settings',
  //             onPressed: () {
  //               openAppSettings(); // Open app settings for the user to grant permission
  //             },
  //           ),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     _scaffoldMessengerKey.currentState?.showSnackBar(
  //       SnackBar(content: Text('Error saving image: $e')),
  //     );
  //   }
  // }

  // Function to share the image file
  Future<void> _shareImage(String url) async {
    try {
      final filePath = await _downloadImageToTemp(url);
      if (filePath != null) {
        await Share.shareXFiles([XFile(filePath)], text: 'Check out this image!');
      }
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Error sharing image: $e')),
      );
    }
  }

  // Show bottom sheet with options
  void _showContextMenu(BuildContext context, String imageUrl) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.download),
                title: Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                 // _downloadImage(imageUrl);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  _shareImage(imageUrl);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: initialIndex);
    ValueNotifier<int> currentIndex = ValueNotifier<int>(initialIndex);

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: GestureDetector(
          onLongPress: () {
            _showContextMenu(context, imageUrls[currentIndex.value]);
          },
          child: PhotoViewGallery.builder(
            itemCount: imageUrls.length,
            pageController: pageController,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrls[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            onPageChanged: (index) {
              currentIndex.value = index; // Update current index on page change
            },
          ),
        ),
      ),
    );
  }
}