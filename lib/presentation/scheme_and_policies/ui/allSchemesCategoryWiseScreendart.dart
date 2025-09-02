import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../provider/allSchemesCategoryWisePro.dart';
import 'SchemeDetails.dart';

class AllSchemesCategoryWiseScreen extends StatefulWidget {
  final String departmentID;
  final String governmentID;

  final String title;

  const AllSchemesCategoryWiseScreen(
      {super.key,
      required this.governmentID,
      required this.title,
      required this.departmentID});

  @override
  State<AllSchemesCategoryWiseScreen> createState() =>
      _AllSchemesCategoryWiseScreenState();
}

class _AllSchemesCategoryWiseScreenState
    extends State<AllSchemesCategoryWiseScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider =
          Provider.of<AllSchemesCategoryWisePro>(context, listen: false);
      await provider.getAllSchemeCategory(
          context: context,
          governmentID: widget.governmentID,
          departmentID: widget.departmentID);
      // await provider.getPolicesCategory(context: context,);
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "All"),
      body: Consumer<AllSchemesCategoryWisePro>(
        builder: (context, pro, child) {
          if (pro.allSchemeCategoryWiseModel == null ||
              pro.allSchemeCategoryWiseModel!.data == null) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: ListShimmerLoader(),),
            );
          }
          if (pro.allSchemeCategoryWiseModel!.data!.isEmpty) {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Image.asset(
                  "assets/icons/emptyList.png",
                  height: 100,
                )));
          }

          return ListView.builder(
            itemCount: pro.allSchemeCategoryWiseModel!.data!.length,
            itemBuilder: (context, categoryIndex) {
              final category =
                  pro.allSchemeCategoryWiseModel!.data![categoryIndex];
              final schemes = category.schemes ?? [];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (category.categoryName != null)
                      Text(
                        category.categoryName!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schemes.length,
                      itemBuilder: (context, schemeIndex) {
                      var  sNO=schemeIndex+1;
                        final colorModel =
                            colorList[schemeIndex % colorList.length];
                        final scheme = schemes[schemeIndex];
                       // final imageUrl = '${ApiConfig.imageBaseUrl}${schemes[schemeIndex].thumbImage}';
                        return CustomCard(
                          isShowSno: true,colorShow: true,

                          sNo: "${sNO}",
                          title: scheme.title ?? 'No Title',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SchemeDetails(
                              imageUrl:schemes[schemeIndex].image!.isEmpty? "null":schemes[schemeIndex].image!.first,
                              title: scheme.title! ,
                              summary:scheme.summary! ,
                               link:scheme.link! ,
                            ),));
                          },
                          color: colorModel.primaryColor,
                          borderColor: colorModel.borderColor,
                        );
                        // return ListTile(
                        //   title: Text(scheme.title ?? 'No Title'),
                        // );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
