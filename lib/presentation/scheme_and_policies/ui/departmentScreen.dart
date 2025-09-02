import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/schemePolicies_screen.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../Culture_Heritage/ui/Culture_heritage.dart';
import '../../letestDrawer.dart';
import '../provider/departmentProvider.dart';
import '../provider/scheme_category_provider.dart';
import 'policyListScreen.dart';
import 'scheme_lists.dart';

class DepartmentListScreen extends StatefulWidget {
  final String governmentID;
  final String title;

  const DepartmentListScreen(
      {super.key, required this.governmentID, required this.title});

  @override
  State<DepartmentListScreen> createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider = Provider.of<DepartmentProvider>(context, listen: false);
      await provider.getDepartment(context: context, id: widget.governmentID);
      // await provider.getPolicesCategory(context: context,);
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  // Widget buildCard(
  //     {required String title,
  //     required VoidCallback onTap,
  //     required Color color,
  //     required Color borderColor}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: 70,
  //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //       margin: EdgeInsets.only(bottom: 10),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: color,
  //         borderRadius: BorderRadius.circular(12),
  //         border: Border.all(color: borderColor),
  //       ),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Expanded(
  //             child: TranslatedText(
  //               title,
  //               textAlign: TextAlign.start,
  //               //softWrap: true,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           Icon(Icons.arrow_forward_ios_rounded)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<DepartmentProvider>(context, listen: false).clearData();
        return true; // allow back navigation
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: widget.title,
            isShowTrans: false,

            leadingBackButton: true,
          ),
         drawer: CustomDrawer2(),
         // drawer: CustomDrawer(),
          body: Consumer<DepartmentProvider>(
            builder: (context, schemeProvider, child) {
              if (schemeProvider.departmentModel?.data == null ||
                  schemeProvider.departmentModel == null) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: const ListShimmerLoader()));
              }
              if (schemeProvider.departmentModel!.data!.isEmpty) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     "List Of Department",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: schemeProvider.departmentModel!.data!.length,
                      itemBuilder: (context, index) {
                        final colorModel = colorList[index % colorList.length];
                        var item = schemeProvider.departmentModel!.data![index];
                        var sNO=index+1;
                        return CustomCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SchemePolicies(
                                        departmentID: item.sId ?? 'N/A',
                                        title: item.name ?? 'N/A',
                                        governmentID: widget.governmentID,
                                      )),
                            );
                          },
                          isShowSno: false,
                          colorShow: true,
                          sNo: "${sNO}",
                          color: colorModel.primaryColor,
                          borderColor: colorModel.borderColor,
                          title: item.name ?? 'N/A',
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
