import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/presentation/publicEngagement_communication/ui/videoPlayerScreen.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../provider/PublicEngagementCommunicationProvider.dart';

class TotalVideoListScreen extends StatefulWidget {
  const TotalVideoListScreen({super.key});

  @override
  State<TotalVideoListScreen> createState() => _TotalVideoListScreenState();
}

class _TotalVideoListScreenState extends State<TotalVideoListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final pro = Provider.of<PublicEngagementCommunicationProvider>(context, listen: false);
    pro.getPublicVideo(context: context, isFirst: true);

    _scrollController.addListener(() {
      final provider = Provider.of<PublicEngagementCommunicationProvider>(context, listen: false);

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !provider.loading &&
          !provider.isLoadMoreRunning &&
          provider.hasMore) {
        provider.getPublicVideo(context: context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "All Video"),
      body: Consumer<PublicEngagementCommunicationProvider>(
        builder: (context, provider, child) {
          final videos = provider.videoPlayerModel?.data ?? [];


          return (provider.videoPlayerModel == null ||
                  provider.videoPlayerModel!.data == null)
              ? CustomShimmerContainer(
                  width: MediaQuery.of(context).size.width, height: 190)
              : provider.videoPlayerModel!.data!.isEmpty
                  ? SizedBox()
                  : ListView.separated(
            controller: _scrollController,
            itemCount: videos.length + (provider.isLoadMoreRunning ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemBuilder: (context, index) {
              if (index == videos.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final video = videos[index];
              final videoUrl = '${ApiConfig.imageBaseUrl}${video.video?.first}';
                    // scrollDirection: Axis.vertical,
                    // itemCount: videos.length,
                    // separatorBuilder: (context, index) =>
                    //     const SizedBox(width: 8.0),
                    // itemBuilder: (context, index) {
                    //   final video = videos[index];
                    //
                    //   '${ApiConfig.imageBaseUrl}${video.thumbImage}';
                    //   final videoUrl =
                    //       '${ApiConfig.imageBaseUrl}${video.video?.first}';
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ScrollableVideoScreen(
                                videoUrls: videos
                                    .map((v) =>
                                        '${ApiConfig.imageBaseUrl}${v.video?.first}')
                                    .toList(),
                                titles: videos
                                    .map((v) => v.title ?? '')
                                    .toList(),
                                initialIndex: index,//passing the index
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey.shade200,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  "${ApiConfig.imageBaseUrl}${video.thumbImage}",
                                  //   'http://167.71.232.245:8978/${video.thumbImage}',
                                  fit: BoxFit.fill,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/emptyImage.jpg",
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                              const Center(
                                child: Icon(Icons.play_circle_fill,
                                    size: 40, color: Colors.white),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius:
                                        BorderRadius.circular(12)),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TranslatedText(
                                      video.title ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
        },
      ),
    );
  }
}
