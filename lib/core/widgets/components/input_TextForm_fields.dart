import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';





Widget inputTextFields( {required TextEditingController textEditingController,
  required String title,
  String? hintText,
  bool obscureText = false,
  bool isTitle=true,
  Widget? prefix,
  Widget? suffix,
  final Function()? onTap,
  TextInputType inputType = TextInputType.text,
  List<TextInputFormatter>? inputFormatter,
  final Function(String)? onChanged, // ✅ Added
  final Function(String)? onFieldSubmitted, // ✅ Added
  bool isRead = false,
  TextCapitalization capitalize = TextCapitalization.sentences,
  RegExp? textRegex,
  int maxLength = 50,
  Color? fillColor = const Color(0xffFFFFFF),
  dynamic maxLines = 1}
    ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isTitle==true?  CustomText(text: title,fontSize: 14,fontWeight: FontWeight.w400,):SizedBox(),
      isTitle==true? SizedBox(height:5):SizedBox(),
      Container(
        clipBehavior: Clip.antiAlias,
        padding:
        EdgeInsets.only( left: 12.0),
        decoration: ShapeDecoration(
          color:  Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          shadows: [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: TextFormField(
          onTap: onTap,
          onChanged: onChanged, // ✅ Use this in IFSC
          onFieldSubmitted: onFieldSubmitted, // ✅ Use this if needed

          controller: textEditingController,
          readOnly: isRead,
          textCapitalization: capitalize,
          keyboardType: inputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatter ?? [],
          cursorColor: Colors.orange,
          maxLines: maxLines,
          maxLength: maxLength,
          obscureText: obscureText,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter $title';
            } else if (textRegex != null) {
              if (!textRegex.hasMatch(value)) {
                return 'Please enter valid $title';
              }
              return null;
            }
            return null;
          },
          decoration: InputDecoration(


              counterText: '',
              hintText: hintText,
              // labelText: title,
              prefixIcon: prefix ?? SizedBox.shrink(),
              suffixIcon: suffix ?? SizedBox(),
              prefixIconConstraints: BoxConstraints(maxWidth: 45),
              suffixIconConstraints: BoxConstraints(maxWidth: 45),
              errorMaxLines: 2,
              filled: true,
              fillColor: fillColor,
              contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              border: InputBorder.none
          ),
        ),
      ),
      SizedBox(height:15),
    ],
  );
}



class CustomText extends StatelessWidget {
  @required
  final String text;
  final double? minFontSize;
  final String? fontFamily;
  final double? fontSize;
  final Color? color;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final double? letterSpace;
  final Locale? locale;
  final TextOverflow? overflow;
  final Paint? foreground;
  final int? maxLine;
  final double? maxFontSize;
  final TextDecoration? lineThrough;
  final Function()? onTap;

  const CustomText(
      {super.key,
        this.minFontSize,
        this.overflow,
        this.color,
        this.align,
        this.fontFamily,
        this.letterSpace,
        this.fontSize,
        this.fontWeight,
        this.locale,
        this.foreground,
        this.maxLine,
        this.maxFontSize,
        required this.text,
        this.lineThrough,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TranslatedText(
        text,
        maxLines: maxLine,
        textAlign: align,
        style: TextStyle(
            letterSpacing: letterSpace,
            foreground: foreground,
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            decoration: lineThrough,
            fontFamily: fontFamily),
      ),
    );
  }
}
