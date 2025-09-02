import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/customCard.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/shimmerEffect.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../provider/scheme_provider.dart';
import 'SchemeDetails.dart';
import 'package:provider/provider.dart';


class schemesListScreen extends StatefulWidget {
  final String departmentID;
  final String governmentID;
  final String schemeCategoryID;


  final String title;

  const schemesListScreen({super.key, required this.schemeCategoryID,required this.governmentID,required this.departmentID, required this.title});

  @override
  State<schemesListScreen> createState() => _schemesListScreenState();
}

class _schemesListScreenState extends State<schemesListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider = Provider.of<SchemeProvider>(context, listen: false);
      await provider.getScheme(context: context, schemeCategory: widget.schemeCategoryID,goverment: widget.governmentID,department: widget.departmentID);

    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    return  WillPopScope(
      onWillPop: () async {
        Provider.of<SchemeProvider>(context, listen: false).clearData();
        return true; // allow back navigation
      },
      child: Scaffold(backgroundColor: Colors.white,
        appBar: CommonAppBar2(title: widget.title,isShowTrans: true,),
        body: Consumer<SchemeProvider>(
          builder: (context, schemeProvider, child) {

            print("hjgdcsjhgcd");
            if (schemeProvider.schemeModel?.data == null) {
              return const Center(child: ListShimmerLoader());
            } if (schemeProvider.schemeModel!.data!.isEmpty) {
              return  SizedBox(
                height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
                  child: Center(child: Image.asset("assets/icons/emptyList.png",height: 100,)));
            }

            print("hjgdcsjhgcd");
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: schemeProvider.schemeModel!.data!.length,
              itemBuilder: (context, index) {
                var  sNO=index+1;
                final colorModel = colorList[index % colorList.length];
                print(">>>>>>>lenth of list ${schemeProvider.schemeModel!.data!.length}>dddd>>>>>>>");
                final imageUrl = '${ApiConfig.imageBaseUrl}${schemeProvider.schemeModel!.data![index].thumbImage}';

                return CustomCard2(
                  sNo: "${sNO}",
                    isShowSno: true,
                    colorShow: true,
                    color: colorModel.primaryColor,
                    borderColor: colorModel.borderColor,
                  title: schemeProvider.schemeModel!.data![index].title.toString() ,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchemeDetails(
                      imageUrl:schemeProvider.schemeModel!.data![index].image!.isEmpty?"null": schemeProvider.schemeModel!.data![index].image!.first.toString(),
                      title: schemeProvider.schemeModel!.data![index].title! ,
                      summary:schemeProvider.schemeModel!.data![index].summary! ,
                      link:schemeProvider.schemeModel!.data![index].link! ,
                    ),));
                  }
                );
              },
            );
          },
        ),
      ),
    );
  }


}