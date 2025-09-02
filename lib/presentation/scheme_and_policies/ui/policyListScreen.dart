// PolicyListProvider


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/presentation/scheme_and_policies/ui/SchemeDetails.dart';
import '../../../../../core/network/api-config.dart';
import '../../../../../core/widgets/components/custom_appbar.dart';
import '../provider/scheme_provider.dart';

import 'package:provider/provider.dart';

import '../../../core/widgets/components/translatorWidget.dart';
import '../provider/policyListProvider.dart';


class PolicyListScreen extends StatefulWidget {
  final String id;
  final String title;

  const PolicyListScreen({super.key, required this.id, required this.title});

  @override
  State<PolicyListScreen> createState() => _PolicyListScreenState();
}

class _PolicyListScreenState extends State<PolicyListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final provider = Provider.of<PolicyListProvider>(context, listen: false);
      await provider.getPolicy(context: context, id: widget.id);

    } catch (e) {
      log('Exception in getData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      appBar: CommonAppBar(title: widget.title),
      body: Consumer<PolicyListProvider>(
        builder: (context, provider, child) {

          print("hjgdcsjhgcd");
          if (provider.policiesModel?.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          print("hjgdcsjhgcd");
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.policiesModel!.data!.length,
            itemBuilder: (context, index) {
              final imageUrl = '${ApiConfig.imageBaseUrl}${provider.policiesModel!.data![index].thumbImage}';
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: _buildCard(
                  context,
                  imageUrl: imageUrl,
                  title: provider.policiesModel!.data![index].title! ,
                  route: SchemeDetails(
                    imageUrl: imageUrl,
                    title: provider.policiesModel!.data![index].title! ,
                    summary:provider.policiesModel!.data![index].summary! ,
                    link: provider.policiesModel!.data![index].link! ,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, {
    required String imageUrl,
    required String title,
    required Widget route,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => route)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/emptyImage.jpg",height: 200,fit: BoxFit.cover,
                      width: double.infinity,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TranslatedText(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}