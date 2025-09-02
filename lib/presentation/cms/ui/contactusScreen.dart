import 'package:flutter/material.dart';
import 'package:samrat_chaudhary/core/widgets/components/custom_appbar.dart';
import 'package:samrat_chaudhary/core/widgets/components/input_TextForm_fields.dart';

import '../../../core/widgets/components/bottom_button.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title:  'Contact Us',),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SizedBox(height: 10,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://files.prokerala.com/news/photos/imgs/1024/samrat-choudhary-the-panchayati-raj-minister-in-1340951.jpg'), // Replace with your leader image
            ),
            const SizedBox(height: 10),
            Text(
              "We'd love to hear from you!",
              style: TextStyle(
                fontSize: 20,
                color: Colors.orange.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Feel free to reach out anytime.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 10,),
            inputTextFields(textEditingController: _nameController, title: "Your Name*"),
            inputTextFields(textEditingController: _emailController, title: "Your Email*"),
            Row(
              children: [
                Text("Message*"),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              clipBehavior: Clip.antiAlias,
              padding:
              EdgeInsets.only( left: 12.0),
              decoration: ShapeDecoration(
                color:  Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                shadows: [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextFormField(
                maxLines: 500,

                cursorColor: Colors.orange,



                decoration: InputDecoration(


                    counterText: '',
                    hintText: "Your Message",
                    // labelText: title,

                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    border: InputBorder.none
                ),
              ),
            ),
            SizedBox(height: 50,),
            BottomButton(title: "Send",onPress: () {

            },)

                ],
              ),
            ),

        );

  }
}
