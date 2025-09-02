import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/helper_functions.dart';

import '../../../videoShowLetets.dart';
import '../../publicEngagement_communication/ui/PublicEngagementScreens.dart';
import '../provider/youTubeProvider.dart';

class YouTubeVideoSection extends StatefulWidget {
  YouTubeVideoSection({Key? key}) : super(key: key);

  @override
  State<YouTubeVideoSection> createState() => _YouTubeVideoSectionState();
}

class _YouTubeVideoSectionState extends State<YouTubeVideoSection> {


  @override
  Widget build(BuildContext context) {
    return Consumer<YouTubeProvider>(
      builder: (context, provider, child) {
        final video = provider.youTubeVideoModel;
        // if (video == null) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: dataListVideo.length,
            itemBuilder: (context, index) {
            return /*index==0?GestureDetector(
              onTap: () {
                var url = 'https://www.youtube.com/watch?v=${video.videoId}';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YouTubeWebViewScreen(
                        videoUrl: url,
                      ),
                    ));
                // HelperFunctions.launchExternalUrl(url);
              },
              //  onTap: () => _launchYouTubeVideo(video.videoId),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Image.network(
                            video.thumbnailUrl,
                          )),
                      ListTile(
                        leading: Image.asset('assets/icons/youtube.png'),
                        title: Text(
                          video.title,
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ): */GestureDetector(
              onTap: () {
                var url = 'https://www.youtube.com/watch?v=${ dataListVideo[index].url.toString()}';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YouTubeWebViewScreen(
                        videoUrl: url,
                      ),
                    ));
                // HelperFunctions.launchExternalUrl(url);
              },
              //  onTap: () => _launchYouTubeVideo(video.videoId),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(

                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  dataListVideo[index].image.toString(),
                                  height: 150,
                                  fit: BoxFit.fill,
                                )),
                            Image.asset('assets/icons/youtube.png',height: 40,)
                          ],
                        ),
                        // ListTile(
                        //   leading: Image.asset('assets/icons/youtube.png'),
                        //   title: Text(
                        //     "video.title",
                        //     style:
                        //     TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },),
        );
      },
    );
  }
}

class VideoSectionData {
  final String image;
  final String url;

  VideoSectionData({required this.image, required this.url});
}

List<VideoSectionData> dataListVideo = [
  VideoSectionData(
      image: "assets/icons/tm1.jpg",
      url: "https://www.youtube.com/watch?v=4BorvD0jzMk"),

  VideoSectionData(
      image: "assets/icons/tm2.jpg",
      url: "https://youtube.com/watch?v=1BI4lgZBjZc"),


];


class YouTubeScreen extends StatefulWidget {
  const YouTubeScreen({super.key});

  @override
  State<YouTubeScreen> createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the latest video when the screen initializes
    final provider = Provider.of<YouTubeProvider>(context, listen: false);
    provider.fetchLatestVideo();
  }

  // Function to launch YouTube URL
  Future<void> _launchYouTubeVideo(String videoId) async {
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Consumer<YouTubeProvider>(
      builder: (context, provider, child) {
        if (provider.youTubeVideoModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return GestureDetector(
          onTap: ()=>HelperFunctions.launchExternalUrl("https://www.youtube.com/watch?v=${provider.youTubeVideoModel!.videoId}"),
       //   onTap: () => _launchYouTubeVideo(provider.youTubeVideoModel!.videoId),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Thumbnail
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        provider.youTubeVideoModel!.thumbnailUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: height*0.12,
                        left: width*0.37,
                        child: Icon(Icons.play_circle,size: 60,))

                  ],
                ),

                // Video Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.youTubeVideoModel!.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}