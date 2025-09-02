// lib/providers/video_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/youTubeModel.dart';

class YouTubeProvider with ChangeNotifier {
  YouTubeVideoModel? _youTubeVideoModel;

  YouTubeVideoModel? get youTubeVideoModel => _youTubeVideoModel;

  final String _apiKey = 'AIzaSyDKrtRoJBFJppOjmUiTeofPngL-JKsvaH8';
  final String _channelId = 'UC1z6aU0yvYrKxan4Joumn5A';

  Future<void> fetchLatestVideo() async {
    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$_channelId&maxResults=1&order=date&type=video&key=$_apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] != null && data['items'].length > 0) {
          _youTubeVideoModel = YouTubeVideoModel.fromJson(data['items'][0]);
          notifyListeners();
        }
      } else {
        throw Exception('Failed to load video');
      }
    } catch (error) {
      throw error;
    }
  }
}
