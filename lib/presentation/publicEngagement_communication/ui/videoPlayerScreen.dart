//   import 'package:flutter/material.dart';
//   import 'package:video_player/video_player.dart';
//
// import '../core/widgets/components/custom_appbar.dart';
//
//   class VideoPlayerScreen extends StatefulWidget {
//     final String videoUrl;
//     final String title;
//
//     const VideoPlayerScreen({
//       Key? key,
//       required this.videoUrl,
//       required this.title,
//     }) : super(key: key);
//
//     @override
//     State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
//   }
//
//   class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//     late VideoPlayerController _controller;
//     bool _hasError = false;
//     bool _isLoading = true;
//
//     @override
//     void initState() {
//       super.initState();
//       initializeVideo();
//     }
//
//     void initializeVideo() {
//       _hasError = false;
//       _isLoading = true;
//
//       _controller = VideoPlayerController.network(widget.videoUrl)
//         ..initialize().then((_) {
//           setState(() {
//             _isLoading = false;
//           });
//           _controller.play();
//         }).catchError((error) {
//           print('Video Error: $error');
//           setState(() {
//             _hasError = true;
//             _isLoading = false;
//           });
//         });
//     }
//
//     @override
//     void dispose() {
//       _controller.dispose();
//       super.dispose();
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       print(">>>>>>>>>>>>>>${widget.videoUrl}");
//       return  Scaffold(backgroundColor: Colors.transparent,
//         appBar: CommonAppBar(title: widget.title,),
//        // appBar: AppBar(title: Text(widget.title)),
//         body: Center(
//           child: _isLoading
//               ? const CircularProgressIndicator()
//               : _hasError
//               ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error, color: Colors.red, size: 50),
//               const SizedBox(height: 10),
//               const Text('Failed to load video.',
//                   style: TextStyle(fontSize: 16)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   initializeVideo();
//                 },
//                 child: const Text('Retry'),
//               ),
//             ],
//           )
//               : AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//         ),
//         floatingActionButton: _controller.value.isInitialized && !_hasError
//             ? FloatingActionButton(
//           backgroundColor: Color(0xffF47216),
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,
//           ),
//         )
//             : null,
//       );
//     }
//   }


import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollableVideoScreen extends StatefulWidget {
  final List<String> videoUrls;
  final List<String> titles;
  final int initialIndex; // <-- Added this

  const ScrollableVideoScreen({
    Key? key,
    required this.videoUrls,
    required this.titles,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<ScrollableVideoScreen> createState() => _ScrollableVideoScreenState();
}

class _ScrollableVideoScreenState extends State<ScrollableVideoScreen> {
  final List<VideoPlayerController> _controllers = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    initControllers();
  }

  void initControllers() async {
    for (var url in widget.videoUrls) {
      print(widget.videoUrls);
      print("widgetvideoUrls");
      print(widget.titles);
      final controller = VideoPlayerController.network(url);
      _controllers.add(controller);
      await controller.initialize();
    }

    setState(() {}); // Refresh UI after all videos initialized

    // 👇 Ensures first video plays and renders after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playOnlyVisible(0);
    });
  }



  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }


  void playOnlyVisible(int index) {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == index) {
        _controllers[i].play();
      } else {
        _controllers[i].pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.black,
     appBar: CommonAppBar(title: "Videos",isShowTrans: false,),
     // appBar: AppBar(),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.videoUrls.length,
        itemBuilder: (context, index) {
          if (index >= _controllers.length ||
              !_controllers[index].value.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }

          final controller = _controllers[index];

          return VisibilityDetector(
            key: Key('video_$index'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.8) {
                playOnlyVisible(index);
              }
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),

                // Center(
                //   child: AspectRatio(
                //     aspectRatio: controller.value.aspectRatio,
                //     child: VideoPlayer(controller),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.titles[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
