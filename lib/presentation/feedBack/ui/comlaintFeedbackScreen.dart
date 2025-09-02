import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/core/widgets/components/translatorWidget.dart';

import 'complaint.dart';
import 'feedbackScreen.dart';

class ComplaintFeedbackScreen extends StatelessWidget {
  const ComplaintFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: CommonAppBar(title: "Support",leadingBackButton: false,),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      context,
                      title: "Complaints",
                      icon: Icons.report_problem_outlined,
                      color: Colors.white,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintScreen(),));
                        // Navigate to feedback screen
                        // Navigate to complaints screen
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      context,
                      title: "Feedback & Suggestions",
                      icon: Icons.feedback_outlined,
                      color: Colors.white,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                        // Navigate to feedback screen
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: const Color(0xFFF47216)),
              const SizedBox(height: 16),
              TranslatedText(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
