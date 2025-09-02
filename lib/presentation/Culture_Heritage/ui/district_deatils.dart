import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

import '../provider/districkDetailProvider.dart';
import '../../../core/network/api-config.dart';
import '../../../core/widgets/components/translatorWidget.dart';


class DistrictDetailScreen extends StatefulWidget {
  final String id;
  final String title;

  const DistrictDetailScreen({super.key, required this.id, required this.title});

  @override
  State<DistrictDetailScreen> createState() => _DistrictDetailScreenState();
}

class _DistrictDetailScreenState extends State<DistrictDetailScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pro = Provider.of<DistrictDetailProvider>(context, listen: false);
    pro.getDistrictDetailApi(context: context, id: widget.id);

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return   WillPopScope(
      onWillPop: () async {
        Provider.of<DistrictDetailProvider>(context, listen: false).clearData();
        return true; // allow back navigation
      },
      child: Scaffold(backgroundColor: Colors.white,
        appBar: CommonAppBar(title: widget.title),
        body: Consumer<DistrictDetailProvider>(
          builder: (context, provider, child) {
            final model = provider.districtDetailModel?.data;

            if (model == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final magistrate = model.magistrates?.isNotEmpty == true ? model.magistrates!.first : null;
            final superintendent = model.superidentents?.isNotEmpty == true ? model.superidentents!.first : null;

            List<String> titles = [
              "Hospital", "Bank", "Postal", "Electricity",
              "College/University", "Municipality", "NGO", "School"
            ];
            List<int> counts = [
              model.hospitalCount ?? 0,
              model.bankCount ?? 0,
              model.postalCount ?? 0,
              model.electrictyCount ?? 0,
              model.collegeCount ?? 0,
              model.municipalityCount ?? 0,
              model.ngoCount ?? 0,
              model.schoolCount ?? 0,
            ];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (magistrate != null || superintendent != null)
                  //   Row(
                  //     children: [
                  //       if (magistrate != null)
                  //         Expanded(child: _buildProfileCard(
                  //           post: 'District Magistrate',
                  //           bgColor: Colors.red.shade100,
                  //           borderColor: Colors.pink,
                  //           image: magistrate.profileImage,
                  //           name: magistrate.name ?? 'N/A',
                  //         )),
                  //       if (magistrate != null && superintendent != null) const SizedBox(width: 12),
                  //       if (superintendent != null)
                  //         Expanded(child: _buildProfileCard(
                  //           post: 'Superintendent of Police',
                  //           bgColor: Colors.blue.shade100,
                  //           borderColor: Colors.blue,
                  //           image: superintendent.profileImage,
                  //           name: superintendent.name ?? 'N/A',
                  //         )),
                  //     ],
                  //   ),
                  // const SizedBox(height: 20),

                  const TranslatedText("About District", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  TranslatedText(model.district?.about ?? 'Not available', style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),

                  _buildStats(heading: "Area", value: model.district?.area ?? 'N/A'),
                  _buildStats(heading: "Population", value: model.district?.populateion ?? 'N/A'),
                  _buildStats(heading: "Literacy Rate", value: model.district?.literacyRate ?? 'N/A'),
                  _buildStats(heading: "Block", value: model.district?.block ?? 'N/A'),
                  _buildStats(heading: "Villages", value: model.district?.village ?? 'N/A'),
                  _buildStats(heading: "Municipality", value: model.district?.muncipality ?? 'N/A'),
                  _buildStats(heading: "Police Station/Out Post", value: model.district?.policeStation ?? 'N/A'),
                  _buildStats(heading: "Language", value: model.district?.language ?? 'N/A'),

                  const SizedBox(height: 20),
                  const TranslatedText("Public Utility", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 3 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: screenWidth > 600 ? 2.0 : 2.5,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TranslatedText(
                                counts[index].toString(),
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TranslatedText(
                                titles[index],
                                style: const TextStyle(fontSize: 14),
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
      ),
    );
  }

  Widget _buildProfileCard({
    required String post,
    required String name,
    required Color bgColor,
    required Color borderColor,
    required String? image,
  }) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TranslatedText(post, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != null && image.isNotEmpty
                  ? Image.network(
                ApiConfig.imageBaseUrl + image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
              )
                  : const Icon(Icons.person, size: 100),
            ),
            TranslatedText(name, style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildStats({required String heading, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: TranslatedText(heading, style: const TextStyle(fontWeight: FontWeight.bold))),
          TranslatedText(value),
        ],
      ),
    );
  }
}
