import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/schemePolicies_screen.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../provider/scheme_category_provider.dart';

import 'departmentScreen.dart';
import 'scheme_lists.dart';

import '../provider/govermentProvider.dart';

class GovermentScreen extends StatefulWidget {
  const GovermentScreen({super.key});

  @override
  State<GovermentScreen> createState() => _GovermentScreenState();
}

class _GovermentScreenState extends State<GovermentScreen>with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    getData();

  }
  @override
  void dispose() {


    super.dispose();
  }

  Future<void> getData() async {
    try {
      final provider = Provider.of<GovermentProvider>(context, listen: false);
      await provider.getGovernment(context: context);
    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  Widget buildCard({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                height: MediaQuery.of(context).size.height*0.37,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                    color: Color(0xFFF28C28).withOpacity(0.4),
                      // color: Color(0xFFF28C28).withOpacity(
                      //     _glowAnimation.value * 0.4),
                      offset: Offset(0, 3),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: Image.network(
                      //     image,
                      //     height: 150,
                      //     width: 150,
                      //     fit: BoxFit.fill,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return Image.asset(
                      //         'assets/images/emptyImage.jpg',
                      //         height: 150,
                      //         width: 150,
                      //         fit: BoxFit.fill,
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      TranslatedText(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

          Positioned(
            right: 15,
            top: 25,
            child: ClipOval(
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.orange),
                    child:
                    const Icon(Icons.arrow_forward, color: Colors.white))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(
          title: "Initiative",
         // title: "Schemes and Policies Information",
          leadingBackButton: false,
          isShowTrans: false,
        ),
    drawer: CustomDrawer2(),
    //    drawer: CustomDrawer(),
        body: Consumer<GovermentProvider>(
          builder: (context, schemeProvider, child) {
            if (schemeProvider.governmentModel?.data == null ||
                schemeProvider.governmentModel == null) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  children: [
                    CustomShimmerContainer( height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width,),
                    SizedBox(height: 10,),
                    CustomShimmerContainer( height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width,),
                  ],
                ),
              );
            }
            if (schemeProvider.governmentModel!.data!.isEmpty) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
                  child: Center(child: Image.asset("assets/icons/emptyList.png",height: 100,)));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //    TranslatedText("Schemes - Government of Bihar",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.orange),),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //  reverse: true,
                      itemCount: schemeProvider.governmentModel!.data!.length,
                      itemBuilder: (context, index) {
                        var item = schemeProvider.governmentModel!.data![index];
                        return buildCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DepartmentListScreen(
                                    governmentID: item.sId ?? 'N/A',
                                      title:index==0? "State":"Country"
                                       // title: item.name ?? 'N/A',
                                      )),
                            );
                          },
                          image: ApiConfig.imageBaseUrl + item.image!,
                          title:index==0? "State":"Country"
                          //title: item.name ?? 'N/A',
                        );
                      },
                    ),
                  ]),
            );
          },
        ));
  }
}
