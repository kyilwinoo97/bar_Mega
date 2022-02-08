import 'dart:ffi';

import 'package:bar_mega/db/DbAccess.dart';
import 'package:bar_mega/menu/ItemDetail.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils.dart';
import '../injection_container.dart';

class ItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  MainRepository repository;
  List<Item> showItemList = [];
  List<Item> mainMenu = [];
  List<Item> desserts = [];
  List<Item> softItem = [
    Item(
        itemId: 1,
        unitId: 0,
        name: "Cocacola",
        price: "1000",
        unit: "Cup",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Blue mountain",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Pepsi",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "M - 150",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Shark",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Red Bull",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Lipo",
        price: "1000",
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
  ];

  //category => main menu,alcoholic drink,soft drink ,desserts
  @override
  void initState() {
    repository = sl<MainRepository>();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Row(
          children: [
            Container(
              color: Colors.white,
              width: mQuery.width * 0.28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CategoryWidget(text: "Main Menu",onPressed: (){
                    setState(() {
                      showItemList.clear();
                      showItemList.addAll(mainMenu);
                    });
                  }),
                  CategoryWidget(text: "Soft Drink",onPressed: (){
                    setState(() {
                      showItemList.clear();
                      showItemList.addAll(softItem);
                    });

                  }),
                  CategoryWidget(text: "Alcoholic Drink",onPressed: (){

                  }),
                  CategoryWidget(text: "Desserts",onPressed: (){
                    setState(() {
                      showItemList.clear();
                      showItemList.addAll(desserts);
                    });

                  }),
                ],
              ),
            ),
        VerticalDivider(
          thickness: 0.4,
          color: Colors.black,
        ),
        Container(
          width: mQuery.width * 0.7,
          child: GridView.count(
            crossAxisCount: 5,
            scrollDirection: Axis.vertical,
            children: List.generate(showItemList.length, (index) {
              return InkWell(child: MenuItem(showItemList[index]),onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemDetail(item: showItemList[index],)));
              },);
            }),
          ),
        ),
      ]
      ),
      floatingActionButton: Container(
        height: 60.0,
        width: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: CupertinoColors.activeGreen,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemDetail()));
            },
            tooltip: "Add Menu",
            child: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }

 Widget CategoryWidget({String text,Function() onPressed}) {
    var mQuery = MediaQuery.of(context).size;
    return   Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: mQuery.width * 0.25,
      child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
          color: CupertinoColors.activeGreen,
          child: Text(text,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),), onPressed: onPressed),
    );
 }

  void getData() async{
   List<Map> result = await repository.getAllMenu();
   for(int i = 0 ; i< result.length ; i ++){
     if(result[i][Sql.Category] == Utils.MainMenu){
       mainMenu.add(Item.fromMap(result[i]));
     }else if(result[i][Sql.Category] == Utils.SoftDrink){

     }else if(result[i][Sql.Category] == Utils.AlcoholicDrink){

     }else if(result[i][Sql.Category] == Utils.Desserts){
       desserts.add(Item.fromMap(result[i]));
     }
   }
   setState(() {
     showItemList.addAll(mainMenu);//default show is main menu
   });

  }
}

class MenuItem extends StatelessWidget {
  final Item item;

  MenuItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, width: 0.5, style: BorderStyle.solid)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: item.path.isNotEmpty
                ? Image.network(
                    item.path,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    "assets/images/menu.png",
                    fit: BoxFit.fill,
                    height: 100,
                  ),
          ),
          Divider(
            height: 0.4,
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: Text(
              item.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
