import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/purchase/NewPurchase.dart';
import 'package:bar_mega/purchase/PurchaseItem.dart';
import 'package:flutter/material.dart';

class Purchase extends StatefulWidget {
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  List<PurchaseItemModel> purchaseItems = [
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(name: 'Rice',qty: '2',unit:'bottle', price: '50000',date: '11-2-2022',supplier: 'Sein Paday Thar MiniMart'),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                      purchaseItems.length, (index) => PurchaseItem(item: purchaseItems[index])),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: NewPurchase(onSave: (){}),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
