import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/presentation/Culture_Heritage/provider/culture_heritage_Provider.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/custom_drawer.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../../publicEngagement_communication/provider/PublicEngagementCommunicationProvider.dart';
import '../../publicFeedback/provider/directory_category_provider.dart';
import 'culture_heritage_detail.dart';
import 'culture_herittage2.dart';
import 'districtListDataScreen.dart';
import 'district_deatils.dart';

class CultureHeritage extends StatefulWidget {
  const CultureHeritage({super.key});

  @override
  State<CultureHeritage> createState() => _CultureHeritageState();
}

class _CultureHeritageState extends State<CultureHeritage> {
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
      appBar: CommonAppBar(
        title: "Culture & Heritage",
        leadingBackButton: false,
      ),
      drawer: CustomDrawer2(),
      //drawer: CustomDrawer(),
      body: Consumer3<CultureHeritageProvider,
          PublicEngagementCommunicationProvider, DirectoryCategoryProvider>(
        builder: (context, provider, bannerPro, directoryProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(
                  "Tourism of Bihar",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                provider.cultureAndHeritagModel?.data == null
                    ? GridShimmerLoader2(

                      )
                    : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio:1, // adjust for tile shape
                  ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            provider.cultureAndHeritagModel!.data!.length,
                        itemBuilder: (context, index) {
                          final data =
                              provider.cultureAndHeritagModel!.data![index];
                          final colorModel =
                              colorList[index % colorList.length];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CultureDetailsScreen(id: data.sId!,name: data.name!,),));

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                     ApiConfig.imageBaseUrl+data.image!.first,
                                      height: MediaQuery.of(context).size.width *
                                          0.3, // responsive height
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset("assets/images/emptyImage.jpg");
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5),
                                    child: TranslatedText(
                                      textAlign: TextAlign.center,
                                      data.name!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );


                        },
                      ),

              ],
            ),
          );
        },
      ),
      // floatingActionButton: buttonSection(color: Color(0xFFF47216),title: "District Wise Info",onTap: (){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => DistrictListDataScreen(),));
      // },buttonColor: Color(0xFFF47216),textColor: Colors.white),

    );
  }

  Widget buttonSection({
    required Color color,
    required Color buttonColor,
    required String title,
    required VoidCallback onTap,
    required Color textColor

  }) {
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
          style:  TextStyle(fontWeight: FontWeight.w500,color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
