import 'package:flutter/material.dart';

Future<void> showNoInternetRetryDialog({
  required BuildContext context,
  required VoidCallback onRetry,
}) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("No Internet"),
      content: Text("Please check your internet connection."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            onRetry(); // Retry the API call
          },
          child: Text("Retry"),
        ),
      ],
    ),
  );
}
