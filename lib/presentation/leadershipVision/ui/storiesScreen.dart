import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:samrat_chaudhary/core/utils/helper_functions.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

class StoryScreen extends StatefulWidget {
  final List<String>? imageList;
  final String title;
  final String date;
  const StoryScreen({super.key, required this.imageList,required this.title,required this.date});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {


  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width*0.235,
       // centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.arrow_back)),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Image.network(
                      ApiConfig.imageBaseUrl + widget.imageList![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            // Text("16 May 2025",style: TextStyle(fontSize: 12),)
            Text(HelperFunctions.formatDate(widget.date),style: TextStyle(fontSize: 12),)
          ],
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("12 May 2025"),
          // )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              items: widget.imageList!.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      child: /*ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                         ApiConfig.imageBaseUrl+ imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/emptyImage.jpg",
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),*/
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InteractiveViewer(
                          panEnabled: true,
                          minScale: 1.0,
                          maxScale: 4.0,
                          child: Image.network(
                            ApiConfig.imageBaseUrl + imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/emptyImage.jpg",
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              //carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,


              //  height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (index == widget.imageList!.length - 1) {
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 10),

            widget.imageList!.length>1?   Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  widget.imageList!.asMap().entries.map((entry) {
                  double width = widget.imageList!.length <= 4
                      ? 60.0
                      : 60.0 - (widget.imageList!.length - 4) * 20.0;

                  // Ensure the width doesn't go below 5.0
                  width = width < 5.0 ? 5.0 : width;
                  return GestureDetector(
                    // onTap: () => _carouselController.jumpToPage(entry.key),
                    child: Container(
                      width: width,
                      height: 5.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //shape: BoxShape.circle,
                        color: _currentIndex == entry.key
                            ? Colors.orange
                            : Colors.grey.shade400,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ):SizedBox.shrink(),
            // Positioned(
            //   bottom: 30,
            //   // left: MediaQuery.of(context).size.width*0.35,
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}
