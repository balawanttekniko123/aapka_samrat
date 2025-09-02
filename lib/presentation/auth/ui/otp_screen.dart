import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:samrat_chaudhary/core/network/environment.dart';
import 'package:samrat_chaudhary/presentation/auth/provider/user_provider.dart';

import '../../../core/widgets/components/bottom_button.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final width = context.screenWidth;
    final height = context.screenHeight;
    return  Scaffold(backgroundColor: Colors.white,
      body:  Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bl.png"),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Consumer<SignUpProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 // Image.asset('assets/images/bl.png'),
                 // const SizedBox(height: 100),
                  SizedBox(height: height*0.56,),
                  Text(
                    'Verify your number',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Enter 4-digit verification code sent to your phone number +91 ${widget.phoneNumber}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Pinput(
                        controller: otpController,
                        length: 4,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(fontSize: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length != 4) {
                            return 'Enter 4-digit OTP';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BottomButton(
                      loading: provider.loading,
                      title: 'Verify OTP',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          provider.verifyOtp(
                            context: context,
                            otp: otpController.text,
                            mobile: widget.phoneNumber,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_start > 0)
                    Text('Resend OTP in $_start seconds')
                  else
                    TextButton(
                      onPressed: () {
                        provider.sendOTPMethod(context: context, mobile: widget.phoneNumber);
                        startTimer();
                      },
                      child: const Text('Resend OTP'),
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
