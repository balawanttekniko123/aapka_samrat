import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../provider/commonSchemesCategoryWisePro.dart';
import 'SchemeDetails.dart';

class CommonSchemesCategoryWiseScreen extends StatefulWidget {
  final String departmentID;
  final String governmentID;
  final String title;

  const CommonSchemesCategoryWiseScreen({
    super.key,
    required this.governmentID,
    required this.title,
    required this.departmentID,
  });

  @override
  State<CommonSchemesCategoryWiseScreen> createState() =>
      _CommonSchemesCategoryWiseScreenState();
}

class _CommonSchemesCategoryWiseScreenState
    extends State<CommonSchemesCategoryWiseScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider =
      Provider.of<CommonSchemesCategoryWisePro>(context, listen: false);
      await provider.getcommonSchemeCategory(
        context: context,
        governmentID: widget.governmentID,
        departmentID: widget.departmentID,
      );
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: widget.title),
      body: Consumer<CommonSchemesCategoryWisePro>(
        builder: (context, pro, child) {
          if (pro.loading) {
            return const Center(child: ListShimmerLoader());
          }

          final data = pro.commonSchemeCategoryWiseModel?.data;

          if (data == null) {
            return const Center(child: Text('Failed to load schemes.'));
          }

          if (data.isEmpty) {
            return Center(
              child: Image.asset(
                "assets/icons/emptyList.png",
                height: 100,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final scheme = data[index];
              final sNo = index + 1;
              final colorModel = colorList[index % colorList.length];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: CustomCard(
                  isShowSno: true,
                  colorShow: true,
                  sNo: "$sNo",
                  title: scheme.title ?? 'No Title',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchemeDetails(
                          imageUrl: (scheme.image != null &&
                              scheme.image!.isNotEmpty)
                              ? scheme.image!.first
                              : "",
                          title: scheme.title ?? "No Title",
                          summary: scheme.summary ?? "",
                          link: scheme.link ?? "",
                        ),
                      ),
                    );
                  },
                  color: colorModel.primaryColor,
                  borderColor: colorModel.borderColor,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

