import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/components/custom_appbar.dart';
import '../provider/directory_Details_provider.dart';

class FeedbackDetails extends StatefulWidget {
  final String title;
  final String districtId;
  final String directoryCategoryId;
  final String subDirectoryCategoryId;

  const FeedbackDetails({
    super.key,
    required this.title,
    required this.districtId,
    required this.directoryCategoryId,
    required this.subDirectoryCategoryId,
  });

  @override
  State<FeedbackDetails> createState() => _FeedbackDetailsState();
}

class _FeedbackDetailsState extends State<FeedbackDetails> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      // final provider =
      // Provider.of<DirectoryDetailsProvider>(context, listen: false);
      // await provider.getFeedBackDetails(
      //   context: context,
      //   districtId: widget.districtId,
      //   directoryCategoryId: widget.directoryCategoryId,
      // );
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final provider =
        Provider.of<DirectoryDetailsProvider>(context, listen: false);
        await provider.getFeedBackDetails(
          context: context,
          districtId: widget.districtId,
          directoryCategoryId: widget.directoryCategoryId,
          subDirectoryCategoryId:widget.subDirectoryCategoryId,
        );
      });

    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  @override
  void dispose() {
    Provider.of<DirectoryDetailsProvider>(context, listen: false)
        .directoryData
        .clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: widget.title),
      body: SafeArea(
        child: Consumer<DirectoryDetailsProvider>(
          builder: (context, provider, _) {
            final departmentData = provider.directoryData;

            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (departmentData.isEmpty) {
              return const Center(child: Text("No data available"));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                //  Text("data"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: departmentData.length,
                    itemBuilder: (context, index) {
                      final item = departmentData[index];


                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFff8000), width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['degignation'] ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFff8000),
                              ),
                            ),
                            //fax
                            //nu
                            const SizedBox(height: 8),
                            rowSection(title: "Mobile No", value: item['number'] ?? 'N/A'),
                            rowSection(title: "Email ID", value: item['email'] ?? 'N/A'),
                           // rowSection(title: "Telephone No", value: item['landline'] ?? 'N/A'),
                            item['landline']==""?SizedBox():   rowSection(
                                title: "Telephone No",
                                value: item['landline'] ?? 'N/A'),

                            // rowSection(
                            //     title: "Telephone No",
                            //     value: item['number']?['number'] ?? 'N/A'),
                            item['fax']==""?SizedBox():   rowSection(
                                title: "fax",
                                value: item['fax'] ?? 'N/A'),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
            // return SingleChildScrollView(
            //   padding: const EdgeInsets.all(16),
            //   scrollDirection: Axis.vertical,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: DataTable(
            //       headingRowColor: MaterialStateProperty.all(const Color(0xFFFF8000)),
            //       headingTextStyle: const TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //       ),
            //       columns: const [
            //         DataColumn(label: Text('Designation')),
            //         DataColumn(label: Text('Mobile Number')),
            //         DataColumn(label: Text('Email')),
            //       ],
            //       rows: List.generate(departmentData.length, (index) {
            //         final item = departmentData[index];
            //         final designation = item['degignation'] ?? 'N/A';
            //         final number = item['number'] ?? 'N/A';
            //         final email = item['email'] ?? 'N/A';
            //
            //         return DataRow(
            //           color: MaterialStateProperty.resolveWith<Color?>(
            //                 (Set<MaterialState> states) {
            //               return index % 2 == 0 ? const Color(0xFFF2F2F2) : null;
            //             },
            //           ),
            //           cells: [
            //             DataCell(Text(designation, style: const TextStyle(fontWeight: FontWeight.bold))),
            //             DataCell(
            //               number != 'N/A'
            //                   ? GestureDetector(
            //                 onTap: () => HelperFunctions.makePhoneCall(number),
            //                 child: Text(number),
            //               )
            //                   : const Text('N/A'),
            //             ),
            //             DataCell(
            //               email != 'N/A'
            //                   ? GestureDetector(
            //                 onTap: () => HelperFunctions.launchEmail(email),
            //                 child: Text(email),
            //               )
            //                   : const Text('N/A'),
            //             ),
            //           ],
            //         );
            //       }),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
  Widget rowSection({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(fontWeight: FontWeight.w500, height: 1.5),
          ),
          Expanded(
            child: (title == "Mobile" || title == "Email") && value != 'N/A'
                ? GestureDetector(
              onTap: () async {
                if (title == "Mobile") {
                  await HelperFunctions.makePhoneCall(value);
                } else if (title == "Email") {
                  await HelperFunctions.launchEmail(value);
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500, height: 1.5,
                  // color: Colors.blue,
                  // decoration: TextDecoration.underline,
                ),
              ),
            )
                : Text(value, style: const TextStyle(height: 1.5)),
          ),
        ],
      ),
    );
  }
}
