import 'package:flutter/material.dart';

mixin Helpers{
  void showSnackBar(BuildContext context,String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error?Colors.red:Colors.green,
      ),
    );
  }
}