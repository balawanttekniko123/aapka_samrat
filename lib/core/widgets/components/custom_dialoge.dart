import 'package:flutter/material.dart';


class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text(
        "Logout",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xffF47216),),
          child: const Text("Cancel",style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: onConfirm, // Call the logout function
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xffF47216),),
          child:  Text("Logout",style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}