import 'package:flutter/material.dart';

import '../../core/api/api_helper.dart';
import '../../core/network/network_info.dart';
import '../../core/storage/auth_token_provider.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/valdationFunctions.dart';
import '../../data/services/api_service.dart';

class CustomComplaintScreen extends StatefulWidget {
  const CustomComplaintScreen({super.key});

  @override
  State<CustomComplaintScreen> createState() => _CustomComplaintScreenState();
}

class _CustomComplaintScreenState extends State<CustomComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _detailsController.dispose();
    super.dispose();
  }


  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final network = NetworkInfo();
      final token = AuthTokenProvider();
      final apiHelper = ApiHelper(network, token);
      final userService = UserService(apiHelper);

      try {
        final feedbackResponse = await userService.submitCustomFeedback(
          name: _nameController.text.trim(),
          contactNumber: _mobileController.text.trim(),
          email: _emailController.text.trim(),
          message: _detailsController.text.trim(),
        );

        // Step 4: Handle the response
        if (feedbackResponse['status'] == true) {
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismissing by tapping outside
            builder: (_) => WillPopScope(
              onWillPop: () async => false, // Disable back button
              child: AlertDialog(
                title: const Text('Thank You!'),
                content: const Text(
                    'You are being directed to Lok Shikayat Portal for filing your complaint'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                     // Navigator.of(context).popUntil((route) => route.isFirst);
                     // await HelperFunctions.launchExternalUrl('https://lokshikayat.bihar.gov.in/onlinegrivance.aspx');
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          );
          _nameController.clear();
          _mobileController.clear();
          _emailController.clear();
          _detailsController.clear();
          _addressController.clear();
        } else {
        }
      } catch (e) {
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFF47216);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Complaint"),
        backgroundColor: orange,
        foregroundColor:Colors.white ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
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
                key: _formKey,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  shadowColor: orange.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          "Complaint Details",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'Name',
                          controller: _nameController,
                          validator: validateName,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Mobile',
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: validatePhoneNumber,
                        ),

                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Address',
                          controller: _addressController,
                          validator: justForEmpty,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Email',
                          controller: _emailController,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Details',
                          controller: _detailsController,
                          maxLines: 4,
                          validator: justForEmpty,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _submitFeedback,
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text("Submit", style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
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
    int maxLength = 10000,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
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
