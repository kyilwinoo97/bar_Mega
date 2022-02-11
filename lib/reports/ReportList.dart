import 'package:bar_mega/reports/ReportDetails.dart';
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(crossAxisCount: 4,
        childAspectRatio: (itemWidth / itemHeight),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: List.generate(10, (index) {
            return InkWell(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => ReportDetails(),
                )
                );
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 100.0,
                child: ReportItem(),
              ),
            );
        }),),
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shadowColor: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('#1-1003',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
            const SizedBox(height: 5.0,),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '1000000', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                  TextSpan(
                    text: '\tKs',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0,),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Discount', style: TextStyle(fontSize: 14.0)),
                  TextSpan(
                    text: '\t5 %',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.date_range,size:
                20.0,color: Colors.blueGrey,),
                const SizedBox(width: 10.0,),
                Text('12-2-2022'),
                // Text("${item.date.day.toString()} / ${item.date.month.toString()} / ${item.date.year.toString()}",style: TextStyle(color: Colors.blueGrey),)
              ],
            ),
          ],
        ),
      ),);
  }
}

