import 'package:flutter/material.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translatorWidget.dart';

class NewsAndMedia extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String summary;


  const NewsAndMedia({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      appBar: CommonAppBar(title: title),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 10,
        ),
        child: Column(
          children: [
            _buildImageSection(context),
            _buildContentSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height:  MediaQuery.of(context).size.height * 0.02,),
        TranslatedText(
          summary,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
