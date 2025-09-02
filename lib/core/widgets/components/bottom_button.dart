import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const BottomButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: size.width,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: Color(0xFFF47216),
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromRGBO(103, 0, 102, 1),
            //     Color.fromRGBO(247, 111, 114, 1)
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.topRight,
            // ),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(0, 0, 0, 0.25))
            ]),
        child: Center(
          child:loading?CircularProgressIndicator(color: Colors.white,): Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Segoe',
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
