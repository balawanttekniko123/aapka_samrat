// lib/models/video_model.dart
class YouTubeVideoModel {
  final String videoId;
  final String title;
  final String thumbnailUrl;

  YouTubeVideoModel({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
  });

  factory YouTubeVideoModel.fromJson(Map<String, dynamic> json) {
    return YouTubeVideoModel(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
    );
  }
}
