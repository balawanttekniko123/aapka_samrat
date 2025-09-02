
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


///16.5
class YouTubeWebViewScreen extends StatefulWidget {
  final String videoUrl;
  const YouTubeWebViewScreen({super.key, required this.videoUrl});

  @override
  YouTubeWebViewScreenState createState() => YouTubeWebViewScreenState();
}

class YouTubeWebViewScreenState extends State<YouTubeWebViewScreen> {
  late final WebViewController _controller;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    String videoId = extractYouTubeId(widget.videoUrl.toString());
    webViewGet(videoId);
  }

  String extractYouTubeId(String url) {
    final RegExp regExp = RegExp(
        r'(?<=v=|\/videos\/|embed\/|youtu.be\/|watch\?v=|watch\?v%3D|v%3D)[^"&?\/\s]{11}');
    final match = regExp.firstMatch(url);
    return match?.group(0) ?? '';
  }


  webViewGet(String videoId) {
    ///webview
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            _controller.runJavaScript('''
              setTimeout(() => {
                // Hide all top elements
                const topElements = document.querySelectorAll(
                  '.ytp-chrome-top, .ytp-title-text, .ytp-menu-button, .ytp-channel-logo, .ytp-logo, .ytp-share-button, .ytp-playlist-bar'
                );
                topElements.forEach(element => {
                  if (element) {
                    element.style.display = 'none';
                  }
                });
                 const title = document.querySelector('.ytp-title-text');
                if (title) {
                  title.style.display = 'none';
                }
                
                      
      // Hide channel and other images
              const images = document.querySelectorAll('img');
              images.forEach(image => {
                if (image) {
                  image.style.display = 'none';
                }
              });
              const settingsMenuItems = document.querySelectorAll('.ytp-settings-menu .ytp-menuitem');
                  settingsMenuItems.forEach(item => {
                    if (item.innerText.includes('More options')) {
                      item.style.display = 'none';
                      console.log('More options button hidden');
                    }
                  });
                  
                     const settingsButton = document.querySelector('.ytp-settings-button');
                if (settingsButton) {
                  settingsButton.addEventListener('click', () => {
                    setTimeout(hideMoreOptions, 500); // Delay to allow the menu to open
                  });
                }
                 // Hide the YouTube button at the bottom
                const youtubeButton = document.querySelector('.ytp-youtube-button');
                if (youtubeButton) {
                  youtubeButton.style.display = 'none';
                }
              }, 2000); // Adjust the timeout as needed
            ''');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            _controller.runJavaScript('''
              setTimeout(() => {
                // Hide all top elements
                const topElements = document.querySelectorAll(
                  '.ytp-chrome-top, .ytp-title-text, .ytp-menu-button, .ytp-channel-logo, .ytp-logo, .ytp-share-button, .ytp-playlist-bar'
                );
                topElements.forEach(element => {
                  if (element) {
                    element.style.display = 'none';
                  }
                });
                 const title = document.querySelector('.ytp-title-text');
                if (title) {
                  title.style.display = 'none';
                }
                const settingsMenu = document.querySelector('.ytp-settings-menu');
                if (settingsMenu) {
                  const moreOptionsButton = Array.from(settingsMenu.querySelectorAll('.ytp-menuitem')).find(item => item.innerText.includes('More options'));
                  if (moreOptionsButton) {
                    moreOptionsButton.style.display = 'none';
                    console.log('More options button hidden');
                  }
                }
                 // Hide the YouTube button at the bottom
                const youtubeButton = document.querySelector('.ytp-youtube-button');
                if (youtubeButton) {
                  youtubeButton.style.display = 'none';
                }
              }, 2000); // Adjust the timeout as needed
            ''');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            // Inject JavaScript to hide top elements
            _controller.runJavaScript('''
              setTimeout(() => {
   console.log('Hiding elements');

                // Function to hide elements
                function hideElement(selector) {
                  const element = document.querySelector(selector);
                  if (element) {
                    element.style.display = 'none';
                    console.log(selector + ' hidden');
                  }
                }

                
                // Hide the More options button in the settings menu
                function hideMoreOptions() {
                  const settingsMenuItems = document.querySelectorAll('.ytp-menuitem');
                  settingsMenuItems.forEach(item => {
                    if (item.innerText.includes('More options')) {
                      item.style.display = 'none';
                      console.log('More options button hidden');
                    }
                  });
                }

                // Listen for settings menu to open and then hide More options
                const observer = new MutationObserver(() => {
                  hideMoreOptions();
                });
                const settingsButton = document.querySelector('.ytp-settings-button');
                if (settingsButton) {
                  observer.observe(settingsButton, { attributes: true });
                }

                // Listen for fullscreen changes
                document.addEventListener('webkitfullscreenchange', (event) => {
                  Toaster.postMessage('fullscreenchange');
                });
                document.addEventListener('fullscreenchange', (event) => {
                  Toaster.postMessage('fullscreenchange');
                });
              }, 2000); // Adjust the timeout as needed
            ''');
            _isLoading = false;
            setState(() {});
          },

          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {

            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'fullscreenchange') {
            _toggleFullScreen(); // Handle orientation change
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          }
        },
      )
      ..loadRequest(
          Uri.parse('https://www.youtube.com/embed/$videoId?rel=0&autoplay=1'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  void _toggleFullScreen() {
    // Assuming you want to switch between landscape and portrait mode
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CommonAppBar(title: 'Videos'),
      // appBar: AppBar(
      //   title: const Text('Videos'),
      // ),
      body:  _isLoading
          ? Center(
        // height: ,
          child: const CircularProgressIndicator())
          : WebViewWidget(
        controller: _controller,
      ),
      //     :  SizedBox(
      //   height: height * 0.3,
      //   width: width,
      //   child:
      // ),
    );
  }
}