import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorScreen({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: Colors.red),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: onRetry,
                child: Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void navigateToError(BuildContext context, String message, Widget retryScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => ErrorScreen(
        message: message,
        onRetry: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => retryScreen),
          );
        },
      ),
    ),
  );
}
