import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../provider/youthProvider.dart';
class YouthScreen extends StatefulWidget {
  const YouthScreen({super.key});

  @override
  State<YouthScreen> createState() => _YouthScreenState();
}

class _YouthScreenState extends State<YouthScreen> {


  @override
  void initState() {
  super.initState();
  init();
  }

  init()  {

      final provider = Provider.of<YouthProvider>(context, listen: false);
      provider.getYouthDetail(context: context);

    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,

      appBar: CommonAppBar(title: "Engagement with youth"),
      body: Consumer<YouthProvider>(builder: (context, provider, child) {
        if(provider.youthModel==null||provider.youthModel!.data==null){
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if(provider.youthModel!.data!.isEmpty){
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("No Data Data Avalable")),
          );
          
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              provider.youthModel?.data == null
                  ? SizedBox(
                height: 150.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : CarouselSlider(
                options: CarouselOptions(
                  height: 190.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                // items: imageList.map((imageUrl) {
                items: provider
                    .youthModel!.data![0].image!
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
                            ApiConfig.imageBaseUrl+imageUrl,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/emptyImage.jpg",fit: BoxFit.fill,);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              TranslatedText(provider.youthModel!.data!.first.summary!,textAlign: TextAlign.justify,style: TextStyle(color: Colors.black.withOpacity(0.6)),)

            ],
          ),
        );
      },),
      
    );
  }
}
