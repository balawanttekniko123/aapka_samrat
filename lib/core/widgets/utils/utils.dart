
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static void fieldFocusChange(
    BuildContext context, 
    FocusNode current,
    FocusNode nextFocus){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

  
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
