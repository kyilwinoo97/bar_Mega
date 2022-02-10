import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: size.width / 2,
          height: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(crossAxisCount: 2,children: [],),
            ),
          ),
        ),
      ),
    );
  }
}
