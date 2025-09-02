import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../provider/scheme_category_provider.dart';
import 'CommonSchemeCategoryScreen.dart';
import 'allSchemesCategoryWiseScreendart.dart';
import 'policyListScreen.dart';
import 'scheme_lists.dart';

class SchemePolicies extends StatefulWidget {
  final String departmentID;
  final String governmentID;
  final String title;

  const SchemePolicies(
      {super.key,
      required this.departmentID,
      required this.governmentID,
      required this.title});

  @override
  State<SchemePolicies> createState() => _SchemePoliciesState();
}

class _SchemePoliciesState extends State<SchemePolicies> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider =
          Provider.of<SchemeCategoryProvider>(context, listen: false);
      await provider.getSchemesCategory(
          context: context, id: widget.departmentID);
      // await provider.getPolicesCategory(context: context,);
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  Widget buildCard({
    // required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, -0.00),
                end: Alignment(0.50, 1.00),
                colors: [const Color(0xFFF47216), const Color(0xFFFFB37E)],
              ),
              borderRadius: BorderRadius.circular(12)
            ),
                               
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.north_east,
                        size: 14, color: Colors.orange),
                  ),
                ],
              ),
              // const SizedBox(height: 8),
              // CircleAvatar(
              //   radius: 45,
              //   backgroundImage: NetworkImage(image),
              // ),
              // const SizedBox(height: 5),
              Flexible(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: TranslatedText(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Expanded(
              //   child: Center(
              //     child: TranslatedText(
              //       title,
              //       textAlign: TextAlign.center,
              //       style: const TextStyle(fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>>>>>>>category>>>>>>>>>>>>>>>>>>>>>");
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SchemeCategoryProvider>(context, listen: false).clearData();
        return true; // allow back navigation
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            isShowTrans: false,
            title: widget.title,
            leadingBackButton: true,
          ),
          drawer: CustomDrawer2(),
          //drawer: CustomDrawer(),
          body: Consumer<SchemeCategoryProvider>(
            builder: (context, schemeProvider, child) {
              if (schemeProvider.schemeCategoryModel?.data == null ||
                  schemeProvider.schemeCategoryModel == null) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: const GridShimmerLoader()));
              }
              if (schemeProvider.schemeCategoryModel!.data!.isEmpty) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Image.asset(
                      "assets/icons/emptyList.png",
                      height: 100,
                    )));
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TranslatedText("Schemes - Government of Bihar",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.orange),),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          schemeProvider.schemeCategoryModel!.data!.length,
                      itemBuilder: (context, index) {
                        var item =
                            schemeProvider.schemeCategoryModel!.data![index];
                        return buildCard(
                          onTap: () {
                           // AllSchemesCategoryWiseScreen
                            if (item.name == "All" ||
                                item.name == "ALL" ||
                                item.name == "all") {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AllSchemesCategoryWiseScreen(
                                      governmentID: widget.governmentID,
                                      departmentID: widget.departmentID,
                                      title: item.name ?? 'N/A',
                                    ),
                                  ));
                            }else  if (item.name == "Common" ||
                                item.name == "COMMON" ||
                                item.name == "common") {
                              //
                              // if (item.name == "Common" ||
                              //     item.name == "COMMON" ||
                              //     item.name == "common") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CommonSchemesCategoryWiseScreen(
                                          governmentID: widget.governmentID,
                                          departmentID: widget.departmentID,
                                          title: item.name ?? 'N/A',
                                        ),
                                  ));
                            }

                            else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => schemesListScreen(
                                          governmentID: widget.governmentID,
                                          departmentID: widget.departmentID,
                                          schemeCategoryID: item.sId ?? 'N/A',
                                          title: item.name ?? 'N/A',
                                        )),
                              );
                            }
                          },
                          //image: ApiConfig.imageBaseUrl + item.thumbImage!,
                          title: item.name ?? 'N/A',
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
