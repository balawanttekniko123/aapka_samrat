import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translatorHtml.dart';
import '../provider/cmsProvider.dart';



class CMSScreen extends StatefulWidget {
  final String title;
  final String content;

  const CMSScreen({super.key,required this.title,required this.content});

  @override
  State<CMSScreen> createState() => _CMSScreenState();
}

class _CMSScreenState extends State<CMSScreen> {


  @override
  Widget build(BuildContext context) {
    print('jghdkgksg${widget.content??' '}');
    return  Scaffold(backgroundColor: Colors.white,
      appBar: CommonAppBar(title: widget.title,),
      body:  SingleChildScrollView(
        //  padding: const EdgeInsets.all(16.0),
        child: widget.content.isNotEmpty
            ? TranslatedHtml(originalText: widget.content)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
