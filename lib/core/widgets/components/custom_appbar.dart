// import 'package:flutter/material.dart';
//
// class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool? leadingBackButton;
//   final Function()? onTap;
//
//   const CommonAppBar({super.key, required this.title, this.leadingBackButton = true, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return AppBar(
//       leading: leadingBackButton == true
//           ? Padding(
//               padding: const EdgeInsets.only(left: 15),
//               child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Image.asset('assets/images/back_button.png')),
//             )
//           : Padding(
//         padding: const EdgeInsets.only(left: 15),
//         child: Builder(
//           builder: (context) => GestureDetector(
//             onTap: () => Scaffold.of(context).openDrawer(),
//             child: Image.asset('assets/images/menu_icon.png', scale: 4.5),
//           ),
//         ),
//       ),
//       title: Text(title,
//           style: TextStyle(
//               // color: Colors.white,
//               fontWeight: FontWeight.w500,
//               fontSize: 16,
//               fontFamily: 'Segoe')),
//       centerTitle: true,
//       flexibleSpace: Container(
//         width: size.width,
//         // height: size.height * 0.3,
//         decoration: BoxDecoration(
//           color: Colors.white
//           // gradient: LinearGradient(
//           //   colors: [
//           //     Color.fromRGBO(103, 0, 102, 1),
//           //     Color.fromRGBO(247, 111, 114, 1),
//           //   ],
//           // ),
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 15),
//           child: Row(
//             children: [
//               InkWell(
//                   onTap:onTap,
//                   child: Image.asset('assets/images/language_icon.png', scale: 4.6)),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';

import '../../../presentation/leadershipVision/provider/home_provider.dart';
import '../../../presentation/leadershipVision/provider/language_provider.dart';
import '../../../data/services/translation_service.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? leadingBackButton;
  final Function()? onTap;
  final bool?isShowTrans;

  const CommonAppBar({
    super.key,
    required this.title,
    this.leadingBackButton = true,
    this.isShowTrans=true,
    this.onTap,
  });

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
  String? _translatedAboutText;
  String? _translatedTitleText;
  final TranslationService _translationService = TranslationService();

  Future<void> _translatePageTexts() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.getLeadershipDetail(context: context);

    if (provider.leadershipDetailModel?.data?.isEmpty ?? true) {
      log('No leadership detail data found');
      return;
    }

    final lang = Provider.of<LanguageProvider>(context, listen: false).currentLanguageCode;

    final summary = provider.leadershipDetailModel!.data!.first.summary ?? '';

    final translations = await _translationService.translateMultipleTexts(
      textsToTranslate: {
        'about': summary,
        'title': 'Samrat Choudhary\'s Political Career',
      },
      toLanguageCode: lang,
    );

    setState(() {
      _translatedAboutText = translations['about'];
      _translatedTitleText = translations['title'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final langProvider = Provider.of<LanguageProvider>(context);

    return AppBar(
      leading: widget.leadingBackButton == true
          ? Padding(
        padding: const EdgeInsets.only(left: 15),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/images/back_button.png'),
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Image.asset('assets/images/menu_icon.png', scale: 4.5),
          ),
        ),
      ),
      title: TranslatedText(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: 'Segoe',
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
      actions: [
        widget.isShowTrans==true?   Padding(
          padding: const EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: () async {
              langProvider.toggleLanguage();
              await _translatePageTexts(); // Refresh content on language toggle
            },
            child: Image.asset('assets/images/language_icon.png', scale: 4.6),
          ),
        ):SizedBox(),
      ],
    );
  }
}


class CommonAppBar2 extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? leadingBackButton;
  final Function()? onTap;
  final bool?isShowTrans;

  const CommonAppBar2({
    super.key,
    required this.title,
    this.leadingBackButton = true,
    this.isShowTrans=true,
    this.onTap,
  });

  @override
  State<CommonAppBar2> createState() => _CommonAppBar2State();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CommonAppBar2State extends State<CommonAppBar2> {
  String? _translatedAboutText;
  String? _translatedTitleText;
  final TranslationService2 _translationService = TranslationService2();

  Future<void> _translatePageTexts() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.getLeadershipDetail(context: context);

    if (provider.leadershipDetailModel?.data?.isEmpty ?? true) {
      log('No leadership detail data found');
      return;
    }

    final lang = Provider.of<LanguageProvider2>(context, listen: false).currentLanguageCode;

    final summary = provider.leadershipDetailModel!.data!.first.summary ?? '';

    final translations = await _translationService.translateMultipleTexts(
      textsToTranslate: {
        'about': summary,
        'title': 'Samrat Choudhary\'s Political Career',
      },
      toLanguageCode: lang,
    );

    setState(() {
      _translatedAboutText = translations['about'];
      _translatedTitleText = translations['title'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final langProvider = Provider.of<LanguageProvider2>(context);

    return AppBar(
      leading: widget.leadingBackButton == true
          ? Padding(
        padding: const EdgeInsets.only(left: 15),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/images/back_button.png'),
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Image.asset('assets/images/menu_icon.png', scale: 4.5),
          ),
        ),
      ),
      title: TranslatedText2(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: 'Segoe',
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
      actions: [
        if (widget.isShowTrans == true)
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () async {
                langProvider.toggleLanguage();
                await _translatePageTexts(); // Refresh app bar title/summary
              },
              child: Image.asset('assets/images/language_icon.png', scale: 4.6),
            ),
          ),
      ],

    );
  }
}

