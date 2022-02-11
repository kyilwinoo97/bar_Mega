import 'package:bar_mega/bloc/purchase_bloc/PurchaseBloc.dart';
import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/purchase/NewPurchase.dart';
import 'package:bar_mega/purchase/PurchaseItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Purchase extends StatefulWidget {
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {

  List<PurchaseItemModel> purchaseItems = [
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
    PurchaseItemModel(
        name: 'Rice',
        qty: '2',
        unit: 'bottle',
        price: '50000',
        date: DateTime.now(),
        supplier: 'Sein Paday Thar MiniMart'),
  ];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: GestureDetector(
              onTap: (){},
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.ad_units_outlined,color: Colors.green,size: 30,),
                      const SizedBox(width: 5.0,),
                      Text(
                        'Add Unit',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: GestureDetector(
              onTap: (){},
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.category,color: Colors.green,size: 30,),
                      const SizedBox(width: 5.0,),
                      Text(
                        'Create Item',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),

        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child:BlocBuilder<PurchaseBloc, PurchaseState>(
                builder: (context, state) {
                  if(state is Success){
                    return Container();
                  }else{
                    return Container();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0),
                    child: AnimationLimiter(
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(purchaseItems.length, (index) {
                          return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 3,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  duration: Duration(milliseconds: 800),
                                  delay: Duration(milliseconds: 100),
                                  child: PurchaseItem(
                                    item: purchaseItems[index],
                                    onTap: () {
                                      var item = purchaseItems[index];
                                      setState(() {
                                        purchaseItems.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
                  );
                }
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
                  child: NewPurchase(onSave: (PurchaseItemModel newItem) {
                    setState(() {
                      purchaseItems = []..add(newItem)..addAll(purchaseItems);
                    });
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() {
    BlocProvider.of<PurchaseBloc>(context).add(GetAllPurchase());
  }
}