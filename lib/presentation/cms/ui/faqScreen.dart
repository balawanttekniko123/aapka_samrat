import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../provider/cmsProvider.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final provider = Provider.of<CMSProvider>(context, listen: false);
    provider.getCms(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: CommonAppBar(title: "FAQs"),
      body: Consumer<CMSProvider>(
        builder: (context, provider, child) {
          if (provider.cmsModel == null || provider.cmsModel!.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }

          if (provider.cmsModel!.data!.first.faq!.isEmpty) {
            return const Center(
              child: Text(
                "No FAQs available right now!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.cmsModel!.data!.first.faq!.length,
            itemBuilder: (context, index) {
              final faq = provider.cmsModel!.data!.first.faq![index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Row(
                      children: [
                        const Icon(Icons.question_answer_outlined, color: Color(0xffF47216)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TranslatedText(
                            faq.question ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      TranslatedText(
                        faq.answer ?? '',
                        style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
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
