import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/components/custom_appbar.dart';
import '../../../core/widgets/components/translatorWidget.dart';
import '../../letestDrawer.dart';
import '../provider/subDirectoriesProvider.dart';
import 'feedback_details.dart';

class subDirectories extends StatefulWidget {
  final String districtID;
  final String directoryCategoryID;
  final String title;

  const subDirectories(
      {super.key,
        required this.districtID,
        required this.directoryCategoryID,
        required this.title});

  @override
  State<subDirectories> createState() => _subDirectoriesState();
}

class _subDirectoriesState extends State<subDirectories> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider =
      Provider.of<SubDirectoryProvider>(context, listen: false);
      await provider.getSubDirectory(
          context: context, directoryCategoryID: widget.directoryCategoryID,districtId: widget.districtID);

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
        Provider.of<SubDirectoryProvider>(context, listen: false).clearData();
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
          body: Consumer<SubDirectoryProvider>(
            builder: (context, schemeProvider, child) {
              if (schemeProvider.subDirectoryModel?.data == null ||
                  schemeProvider.subDirectoryModel == null) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: const CircularProgressIndicator()));
              }
              if (schemeProvider.subDirectoryModel!.data!.isEmpty) {
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
                      schemeProvider.subDirectoryModel!.data!.length,
                      itemBuilder: (context, index) {
                        var item =
                        schemeProvider.subDirectoryModel!.data![index];
                        return buildCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  FeedbackDetails(
                                            title: widget.title,
                                            directoryCategoryId:
                                                widget.directoryCategoryID,
                                            districtId: widget.districtID,
                                            subDirectoryCategoryId: item.sId??'',
                                ),
                              ),
                            );
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
