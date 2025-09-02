import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/environment.dart';
import 'package:samrat_chaudhary/core/widgets/components/bottom_button.dart';
import 'package:samrat_chaudhary/presentation/auth/provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final width = context.screenWidth;
    final height = context.screenHeight;

    return  Scaffold(backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bl.png"),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Consumer<SignUpProvider>(
            builder: (context, provider, child) {
              return Column(

                children: [
                 // Image.asset('assets/images/bl.png'),
                  //Image.asset('assets/images/loginIcon.png'),
                  // 60.height,
                  SizedBox(height: height*0.6,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mobile number is required';
                            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Please Enter Your mobile number',
                            labelText: 'Mobile Number',
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  30.height,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BottomButton(
                      loading: provider.loginLoading,
                      title: 'Send OTP',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.sendOTPMethod(
                            context: context,
                            mobile: mobileController.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
