import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:flutter/material.dart';

class PurchaseItem extends StatelessWidget {
  PurchaseItemModel item;
  Function onTap;
  PurchaseItem({this.item, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      shadowColor: Colors.grey.shade100,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.red.shade50, // Button color
                    child: InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: onTap,
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.red,
                          )),
                    ),
                  ),
                ),
              )),
          Text(item.name,style: TextStyle(fontSize: 22.0,color: Colors.green,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10.0,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: item.qty, style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '\t${item.unit}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0,),
          Text(item.price + ' Ks',style: TextStyle(fontSize: 20.0,),),
          const SizedBox(height: 5.0,),
          Text(item.supplier,style: TextStyle(fontSize: 16.0),),
          const SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.date_range,size:
                20.0,color: Colors.blueGrey,),
              const SizedBox(width: 10.0,),
              Text("${item.date.toString()}",style: TextStyle(color: Colors.blueGrey),)
            ],
          ),
        ],
      ),
    );
  }
}
