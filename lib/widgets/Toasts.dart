import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts{
  Toasts._();
  static void greenToast(String _msg) {
    Fluttertoast.showToast(
      msg: _msg,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 13,
      backgroundColor: Colors.green,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}