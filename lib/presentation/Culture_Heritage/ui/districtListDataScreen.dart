import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../publicEngagement_communication/provider/PublicEngagementCommunicationProvider.dart';
import '../../publicFeedback/provider/directory_category_provider.dart';
import '../provider/culture_heritage_Provider.dart';
import 'district_deatils.dart';

class DistrictListDataScreen extends StatefulWidget {
  const DistrictListDataScreen({super.key});

  @override
  State<DistrictListDataScreen> createState() => _DistrictListDataScreenState();
}

class _DistrictListDataScreenState extends State<DistrictListDataScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pro = Provider.of<CultureHeritageProvider>(context, listen: false);
    final pro2 = Provider.of<PublicEngagementCommunicationProvider>(context,
        listen: false);
    // pro.getCultureBannerApi(context: context);
    pro.getDistrictApi(context: context);
    pro2.getPublicBanner(context: context);
    final provider =
        Provider.of<DirectoryCategoryProvider>(context, listen: false);

    provider.getDistrictApi(context: context);
    final pro4 = Provider.of<CultureHeritageProvider>(context, listen: false);
    pro4.getCultureBannerApi(context: context);
    pro4.getCultureListDistrictIDApi(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "District Wise Information"),
      body: Consumer<DirectoryCategoryProvider>(
        builder: (context, directoryProvider, child) {
          return directoryProvider.districtListModel?.data == null
              ? CustomShimmerContainer(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(

                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        directoryProvider.districtListModel!.data!.length,
                    itemBuilder: (context, index) {

                      var  sNO=index+1;
                      return GestureDetector(
                        onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DistrictDetailScreen(
                                              id:  directoryProvider.districtListModel!.data![index].sId ?? "",
                                              title:  directoryProvider.districtListModel!.data![index].districtName ?? "Unknown",
                                              // districtData: district,
                                            ),
                                          ),
                                        );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 4),
                                // Pushes shadow only downward
                                blurRadius: 6,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child:  Row(
                            children: [
                              TranslatedText(
                                "$sNO.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  // color: colorModel,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  directoryProvider.districtListModel!.data![index].districtName ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );


                      // return buttonSection(
                      //   textColor: Colors.black,
                      //   color: colorModel.primaryColor,
                      //   buttonColor: colorModel.borderColor,
                      //   title: district.districtName ?? "Unknown",
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => DistrictDetailScreen(
                      //           id: district.sId ?? "",
                      //           title: district.districtName ?? "Unknown",
                      //           // districtData: district,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                  ),
                );
        },
      ),
    );
  }

  Widget buttonSection(
      {required Color color,
      required Color buttonColor,
      required String title,
      required VoidCallback onTap,
      required Color textColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonColor),
        ),
        child: TranslatedText(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
