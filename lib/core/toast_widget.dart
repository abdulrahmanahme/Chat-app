
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {

 static Future successBar({
    @required String? message,
  }) {
    return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
static   Future errorBar({
    @required String? message,
  }) {
    return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
