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
import 'culture_heritage_detail.dart';
import 'district_deatils.dart';


class CultureHeritage2 extends StatefulWidget {
  final String districtID;
  const CultureHeritage2({super.key,required this.districtID});

  @override
  State<CultureHeritage2> createState() => _CultureHeritage2State();
}

class _CultureHeritage2State extends State<CultureHeritage2> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pro = Provider.of<CultureHeritageProvider>(context, listen: false);
    pro.getCultureBannerApi(context: context);
    pro.getCultureListDistrictIDApi(context: context);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Culture & Heritage",leadingBackButton: false,),
    //  drawer: CustomDrawer(),
      drawer: CustomDrawer2(),
      body: Consumer<CultureHeritageProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TranslatedText(
                  "Bihar Cultural Festival",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                provider.cultureBannerModel?.data?[0].image == null
                    ? CustomShimmerContainer(
                    width: MediaQuery.of(context).size.width,
                    height: 150)
                    : CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: provider.cultureBannerModel!.data![0].image!
                      .map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.orange.shade100,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ApiConfig.imageBaseUrl + imageUrl,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return
                                  Image.asset("assets/images/emptyImage.jpg");
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),



                const SizedBox(height: 16),
                provider.cultureAndHeritagModel?.data == null
                    ? CustomShimmerContainer(
                    width: MediaQuery.of(context).size.width,
                    height: 150)
                    : ListView.builder(

                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.cultureAndHeritagModel!.data!.length,
                  itemBuilder: (context, index) {
                    final data = provider.cultureAndHeritagModel!.data![index];
                    final colorModel = colorList[index % colorList.length];

                    return GestureDetector(
                      onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CultureDetailsScreen(id: data.sId!,name: data.name!,),));

                      },
                      child: Container(
                        // height: 80,
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorModel.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorModel.borderColor),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius:30,

                              backgroundImage: NetworkImage(ApiConfig.imageBaseUrl+data.image!.first.toString()),
                            ),
                            SizedBox(width: 5,),
                            TranslatedText(
                              data.name ?? "Unknown",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget buttonSection({
    required Color color,
    required Color buttonColor,
    required String title,
    required VoidCallback onTap,
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
          style: const TextStyle(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


