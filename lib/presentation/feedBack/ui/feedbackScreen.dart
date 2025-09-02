import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';

import '../../../core/widgets/components/bottom_button.dart';
import '../provider/feedbackProvider.dart';


class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedbackProvider>(context);
    final orange = Colors.orange;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CommonAppBar(title: "Feedback"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top banner or image
            Container(
              height: 100,
                width: 100,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Color(0xFFF47216),
                    borderRadius: BorderRadius.circular(100)
                ),

                child: Center(child: Icon(Icons.person,size: 70,color: Colors.white,))),
            // Image.asset(
            //   'assets/images/samratIcon.png',
            //   scale: 6,
            // ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: provider.formKey,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  shadowColor: orange.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const TranslatedText(
                          "Share your thoughts",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'Name',
                          controller: provider.nameController,

                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Mobile',
                          controller: provider.mobileController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10

                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Address',
                          controller: provider.addressController,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Feedback',
                          controller: provider.feedbackController,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 24),
                        //our suggestion and feed back
                        //comlaint section

                        ElevatedButton.icon(
                          onPressed: () => provider.submitFeedback(context),

                          icon: const Icon(Icons.send,color: Colors.white,),
                          label: const TranslatedText("Submit Feedback",style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF47216),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,

    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    int maxLength=10000,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (value) =>
      value == null || value.trim().isEmpty ? '$label is required' : null,
      decoration: InputDecoration(
        labelText: label,
        counterText: "",

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2),
        ),
      ),
    );
  }
}
