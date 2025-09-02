import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.orange.shade50,
      appBar: CommonAppBar(title:  'Support Our Leader',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://files.prokerala.com/news/photos/imgs/1024/samrat-choudhary-the-panchayati-raj-minister-in-1340951.jpg'), // Replace with your leader image
            ),
            const SizedBox(height: 20),
            Text(
              "Join the Movement!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Support our leader for a better future.\nYour contribution matters!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Add action (example: open donation link or form)
              },
              icon: const Icon(Icons.volunteer_activism, color: Colors.white),
              label: const Text(
                "Support Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.orange),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Add action (example: contact team)
              },
              icon: const Icon(Icons.chat, color: Colors.orange),
              label: const Text(
                "Contact Support Team",
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
