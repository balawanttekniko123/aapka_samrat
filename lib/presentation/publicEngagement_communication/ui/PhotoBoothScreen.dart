


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/api-config.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import '../../../core/utils/helper_functions.dart';
import '../provider/photoBoothProvider.dart';
import 'full_screen_gallery_screen.dart';
import 'gridImageScreen.dart';

class PhotoBoothScreen extends StatefulWidget {
  @override
  _PhotoBoothScreenState createState() => _PhotoBoothScreenState();
}

class _PhotoBoothScreenState extends State<PhotoBoothScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();

    _scrollController.addListener(() {
      final provider = Provider.of<PhotoBoothProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !provider.loading &&
          !provider.isLoadMoreRunning &&
          provider.hasNextPage) {
        provider.getPhotoBooth(
          context: context,
          startDate: "",
          endDate: "",
          isLoadMore: true,
        );
      }
    });
  }


  init() {
    final pro = Provider.of<PhotoBoothProvider>(context, listen: false);
    pro.getPhotoBooth(context: context, endDate: "", startDate: "");
  }

  TextEditingController _searchController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;
  int _currentImageIndex = 0;

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
      isFromDate ? _fromDate ?? DateTime.now() : _toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoBoothProvider>(builder: (context, provider, child) {
      // Filter items based on search input
      final allItems = provider.publicPhotoModel?.data ?? [];

      // search filter ke liye (pagination original data pe chalega)
      final filteredItems = allItems.where((item) {
        final searchQuery = _searchController.text.toLowerCase();
        return item.summary?.toLowerCase().contains(searchQuery) ?? false;
      }).toList();

      if (provider.loading && provider.publicPhotoModel == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (filteredItems.isEmpty) {
        return const Center(child: Text("No data available"));
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBar(title: "Photo Gallery"),
        body: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by summary',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xffFFDABF),
                ),
                onChanged: (value) {
                  setState(() {}); // Trigger rebuild on search input
                },
              ),
              SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8.0),
                        InkWell(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _fromDate == null
                                      ? 'Select Date'
                                      : DateFormat('dd MMM yyyy')
                                      .format(_fromDate!),
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8.0),
                        InkWell(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _toDate == null
                                      ? 'Select Date'
                                      : DateFormat('dd MMM yyyy')
                                      .format(_toDate!),
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      final pro =
                      Provider.of<PhotoBoothProvider>(context, listen: false);

                      String formattedStartDate = _fromDate != null
                          ? DateFormat('yyyy-MM-dd').format(_fromDate!)
                          : '';
                      String formattedEndDate = _toDate != null
                          ? DateFormat('yyyy-MM-dd').format(_toDate!)
                          : '';

                      pro.getPhotoBooth(
                        context: context,
                        startDate: formattedStartDate,
                        endDate: formattedEndDate,
                      );
                    },
                    child: Container(
                      width: 69,
                      height: 38,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF47216),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Search',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              provider.publicPhotoModel?.data == null
                  ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              )
                  : filteredItems.isEmpty
                  ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("No data available")))
                  : SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                                    controller: _scrollController,
                                    // padding: const EdgeInsets.all(14.0),
                                    // shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: filteredItems.length + (provider.isLoadMoreRunning ? 1 : 0),
                                    itemBuilder: (context, index) {
                    if (index < filteredItems.length) {
                      final item = filteredItems[index];
                      DateTime dateTime = DateTime.parse(item.createdAt.toString());

                        return  Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageGridScreen(
                                imageUrls: item.image!
                                    .map((img) =>
                                ApiConfig.imageBaseUrl + img)
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: const Color(0xFFD9D9D9),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      height: 180.0,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentImageIndex = index;
                                        });
                                      },
                                    ),
                                    items: item.image!.map((imgUrl) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius
                                                      .circular(
                                                      12.0)),
                                              image: DecorationImage(

                                                image: NetworkImage(
                                                    ApiConfig
                                                        .imageBaseUrl +
                                                        imgUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  Positioned(//todo
                                    top: 10,
                                    right: 10,
                                    child: GestureDetector(
                                      // onTap: () async {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //     SnackBar(content: Text('Download started')),
                                      //   );
                                      //   final List<String> fullUrls = item.image!
                                      //       .map((img) => ApiConfig.imageBaseUrl + img)
                                      //       .toList();
                                      //   await HelperFunctions().downloadImagesWithHttp(fullUrls);
                                      // },
                                      onTap: () async {
                                        final List<String> fullUrls = item.image!
                                            .map((img) => ApiConfig.imageBaseUrl + img)
                                            .toList();
                                        await HelperFunctions().downloadImagesWithHttp(context, fullUrls);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.download_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: item.image!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentImageIndex ==
                                                entry.key
                                                ? Colors.white
                                                : Colors.white
                                                .withOpacity(0.4),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  item.summary!,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight:
                                      FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );}
                                    },
                                  ),
                  ),
            ],
          ),
        ),
      );
    });
  }
}

class PhotoBoothItem {
  final DateTime date;
  final String imageUrl;
  final String title;
  final int likeCount;

  PhotoBoothItem({
    required this.date,
    required this.imageUrl,
    required this.title,
    required this.likeCount,
  });
}