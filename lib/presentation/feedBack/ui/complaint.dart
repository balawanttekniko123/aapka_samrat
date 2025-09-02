import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';

import '../../../core/utils/helper_functions.dart';
import '../../customWidget/custom_Form.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white;
    final shadowColor = Colors.orange.shade300;

    return Scaffold(
      appBar:CommonAppBar(title: "Complaint"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            _buildCard(
              context,
              title: 'Lok Shikayat',
              icon: Icons.description,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomComplaintScreen()),
                );
              },
              cardColor: cardColor,
              shadowColor: shadowColor,
            ),
            _buildCard(
              context,
              title: 'Status',
              icon: Icons.assignment_turned_in,
              onTap: () {
               // HelperFunctions.launchExternalUrl('https://lokshikayat.bihar.gov.in/');
                //
                // HelperFunctions.launchExternalUrl('https://lokshikayat.bihar.gov.in/onlinegrivance.aspx');
                // Navigate to Status Check screen
              },
              cardColor: cardColor,
              shadowColor: shadowColor,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
        required Color cardColor,
        required Color shadowColor,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: const Color(0xFFF47216)),
            const SizedBox(height: 20),
            TranslatedText(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
