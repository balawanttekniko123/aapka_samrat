import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color borderColor;
  final String sNo;
  final bool isShowSno;
  final bool colorShow;

  const CustomCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isShowSno,
    required this.color,
    required this.sNo,
required this.colorShow,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:colorShow==true? color:Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color:colorShow==true? borderColor:Color(0xffF47216)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isShowSno==true?   Text("${sNo}. ",textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),):SizedBox(),
            Expanded(
              child: TranslatedText(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,size: 22,),
          ],
        ),
      ),
    );
  }
}
class CustomCard2 extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color borderColor;
  final String sNo;
  final bool isShowSno;
  final bool colorShow;

  const CustomCard2({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isShowSno,
    required this.color,
    required this.sNo,
required this.colorShow,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:colorShow==true? color:Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color:colorShow==true? borderColor:Color(0xffF47216)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isShowSno==true?   Text("${sNo}. ",textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),):SizedBox(),
            Expanded(
              child: TranslatedText2(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,size: 22,),
          ],
        ),
      ),
    );
  }
}



class ColorModel {
  Color primaryColor;
  Color borderColor;

  ColorModel({
    required this.primaryColor,
    required this.borderColor,
  });
}
final List<ColorModel> colorList = [
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
  ColorModel(primaryColor: Colors.red.shade100, borderColor: Colors.red),
  ColorModel(primaryColor: Colors.blue.shade100, borderColor: Colors.blue),
  ColorModel(primaryColor: Colors.green.shade100, borderColor: Colors.green),
  ColorModel(primaryColor: Colors.yellow.shade100, borderColor: Colors.yellow),
];