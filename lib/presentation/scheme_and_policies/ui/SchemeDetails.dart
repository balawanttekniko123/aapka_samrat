import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translateMarkDown.dart';
import '../../../core/widgets/components/translatorHtml.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;


class SchemeDetails extends StatefulWidget {
  final String imageUrl;
  final String title;
  final dynamic summary;
  final dynamic link;

  const SchemeDetails({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.link,
  });

  @override
  State<SchemeDetails> createState() => _SchemeDetailsState();
}

class _SchemeDetailsState extends State<SchemeDetails> {
  void _handleApplyLink(BuildContext context, String link) {
    if (_isValidUrl(link)) {
      HelperFunctions.launchExternalUrl(link);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HowToApplyScreen(link: link),
        ),
      );
    }
  }

  bool _isValidUrl(String link) {
    final uri = Uri.tryParse(link);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>this is my summery data ");
    print("${widget.summary}");
    print("|||||||||||||||||||||||||||||||||||||||||||||||||||");

    print(">>>>>>>>>this is my summery link ");
    print("${widget.link}");
    final String imageUrl = widget.imageUrl == "null" || widget.imageUrl.isEmpty
        ? "public/scheme/scheme-1748610612587.jpg" // Mark to show dummy image
        : widget.imageUrl;

    final String title = widget.title.length < 50
        ? "Government Scheme for Youth Empowerment"
        : widget.title;

    final dynamic summary = widget.summary == null ||
        widget.summary.toString().trim().length < 500
        ? "<p><strong>मुख्यमंत्री पिछड़ा वर्ग एवं अत्यंत पिछड़ा वर्ग प्री-मैट्रिक छात्रवृत्ति योजना</strong> बिहार सरकार द्वारा चलाई जा रही एक कल्याणकारी योजना है, जिसका उद्देश्य राज्य के पिछड़ा वर्ग (OBC) और अत्यंत पिछड़ा वर्ग (EBC) के छात्रों को प्री-मैट्रिक स्तर (कक्षा 1 से 10 तक) पर आर्थिक सहायता प्रदान करना है ताकि वे बिना किसी आर्थिक बाधा के अपनी शिक्षा जारी रख सकें।</p><p><strong>मुख्य उद्देश्य:</strong></p><ul><li>आर्थिक रूप से कमजोर पिछड़ा वर्ग एवं अत्यंत पिछड़ा वर्ग के छात्रों को प्रोत्साहित करना।</li><li>स्कूली शिक्षा को बढ़ावा देना।</li><li>स्कूल छोड़ने की दर (dropout rate) को कम करना।</li></ul><p><strong>लाभार्थी:</strong></p><ul><li>बिहार राज्य के निवासी।</li><li>पिछड़ा वर्ग (BC) या अत्यंत पिछड़ा वर्ग (EBC) से संबंधित छात्र।</li><li>कक्षा 1 से 10 तक के छात्र।</li><li>पारिवारिक वार्षिक आय एक निश्चित सीमा से कम होनी चाहिए (आमतौर पर ₹1.5 लाख से ₹2.5 लाख तक, समय-समय पर यह राशि बदल सकती है)।</li></ul><p><strong>छात्रवृत्ति की राशि:</strong></p><p>छात्र की कक्षा और श्रेणी के अनुसार छात्रवृत्ति की राशि भिन्न हो सकती है, लेकिन सामान्यतः इसमें निम्नलिखित शामिल होते हैं:</p><ul><li>कक्षा 1 से 4 तक: ₹600 प्रति वर्ष&nbsp;</li><li>कक्षा 5 से 8 तक: ₹1200 प्रति वर्ष&nbsp;</li><li>कक्षा 7 और 10 तक: ₹1800 प्रति वर्ष&nbsp;</li><li>कक्षा 1 से 10 तक (छात्रावासी) &nbsp;₹3000 प्रति वर्ष&nbsp;</li></ul><p>&nbsp;</p>": widget.summary;

    final String link = widget.link.toString().length < 300 ? "<p><strong>आवेदन प्रक्रिया:</strong></p><ol><li><strong>ऑनलाइन आवेदन:</strong><ul><li>बिहार सरकार के शिक्षा विभाग की वेबसाइट या छात्रवृत्ति पोर्टल <a href=\"https://medhasoft.bihar.gov.in/\">https://medhasoft.bih.nic.in </a>पर जाकर आवेदन किया जा सकता है।</li></ul></li><li><strong>दस्तावेज़ आवश्यक:</strong><ul><li>छात्र का आधार कार्ड</li><li>जाति प्रमाण पत्र</li><li>आय प्रमाण पत्र</li><li>विद्यालय से नामांकन प्रमाण पत्र</li><li>बैंक खाता विवरण (छात्र या अभिभावक के नाम)</li><li>पासपोर्ट साइज फोटो</li></ul></li></ol><p><strong>महत्वपूर्ण बातें:</strong></p><ul><li>छात्र को नियमित रूप से स्कूल जाना चाहिए।</li><li>पहले से अन्य किसी सरकारी छात्रवृत्ति योजना का लाभ नहीं ले रहा हो।</li></ul>" : widget.link;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CommonAppBar2(
        title: widget.title,
        isShowTrans: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 10,
        ),
        child: Column(
          children: [
            // TranslatedText2(
            //   "निबंध, गद्य विधा की एक लेखन शैली है",
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 16,
            //   ),
            // ),
            _buildImageSection(context: context,imageUrl: imageUrl),
            SizedBox(
              height: 10,
            ),
            _buildContentSection(context: context,summary: summary),
            SizedBox(
              height: 10,
            ),
            link != ""
                ? GestureDetector(
                    onTap: () => _handleApplyLink(context, link),
                    // onTap: () {
                    //   HelperFunctions.launchExternalUrl(link);
                    //   Navigator.push(context, MaterialPageRoute(builder: (context) => HowToApplyScreen(link: link,),));
                    //
                    // },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "How To Apply",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  )
                : SizedBox(),

            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          final document = htmlParser.parse(widget.summary.toString());
          final plainText = document.body?.text ?? '';

          final shareText =
              '${widget.title}\n\n$plainText\n\nRead more: ${widget.link}';

          Share.share(shareText);
          // final shareText =
          //     '${widget.title}\n\n${widget.summary}\n\nRead more: ${widget.link}';
          // Share.share(shareText); // <-- Trigger sharing
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(20)),
          child: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection({required BuildContext context, required String imageUrl}) {
    print(">>>>>>>image hai ki nhi >>>>>>>>${imageUrl}");
    return imageUrl == "null"
        ? SizedBox()
        : ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network( "${ApiConfig.imageBaseUrl}${imageUrl}",errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/emptyImage.jpg");
            }, loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 250, // apne hisab se fix height rakho
                  width: double.infinity,
                  color: Colors.white,
                ),
              );
            },),
          );
  }

  Widget _buildContentSection({required BuildContext context,required String summary}) {
    print(">>>>>>>>>>>>>>>>>html content summery>>>>>>>>>>>>>>>>>>${summary}<<<<<<<<<<<<<<<<<<<<<<<<<");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TranslatedHtml2(
          originalText:summary,

        ),

        // Html(data: widget.summary,)
        // TranslatedMarkdown(
        //   originalText: widget.summary,
        // ),
      ],
    );
  }
}

class HowToApplyScreen extends StatefulWidget {
  final dynamic link;

  const HowToApplyScreen({super.key, required this.link});

  @override
  State<HowToApplyScreen> createState() => _HowToApplyScreenState();
}

class _HowToApplyScreenState extends State<HowToApplyScreen> {
  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>link:");
    print(widget.link);


    return Scaffold(
      appBar: CommonAppBar2(title: "" ,isShowTrans: true,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            TranslatedHtml2(
              originalText: widget.link,
            ),
           // Html(data: widget.link)
            // TranslatedMarkdown(
            //   // originalText: widget.link,
            //   originalText: cycleYojanaInfo,
            // ),
          ],
        ),
      ),
    );
  }
}
