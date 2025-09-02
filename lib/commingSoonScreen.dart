import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
class ComminSoonScreen extends StatefulWidget {
  const ComminSoonScreen({super.key});

  @override
  State<ComminSoonScreen> createState() => _ComminSoonScreenState();
}

class _ComminSoonScreenState extends State<ComminSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Comming",isShowTrans: false,),
      body: Center(
        child: Text("Comming Soon"),
      ),
    );
  }
}
