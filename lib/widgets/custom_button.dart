import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String label='';
  Function onTap;
  Color color;
  CustomButton({this.label,this.color,this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 0.0,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
