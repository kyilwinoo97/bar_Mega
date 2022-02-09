import 'dart:ffi';

import 'package:bar_mega/db/DbAccess.dart';
import 'package:bar_mega/menu/MenuDetail.dart';
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
  List<Item> allItems = [];
  List<Item> mainMenu = [];
  List<Item> desserts = [];
  List<Item> alcoholicDrinks = [
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
  ];
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
  List<String> cats = Utils.categoryList;
  String selectedCat;

  //category => main menu,alcoholic drink,soft drink ,desserts
  @override
  void initState() {
    repository = sl<MainRepository>();
    selectedCat = cats[0];
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
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CategoryWidget(
                        label: cats[0],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[0];
                              showItemList.clear();
                              showItemList.addAll(allItems);
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[1],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[1];
                              showItemList.clear();
                              showItemList.addAll(mainMenu);
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[2],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[2];
                              showItemList.clear();
                              showItemList.addAll(softItem);
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[3],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[3];
                              showItemList.clear();
                              showItemList.addAll(alcoholicDrinks);
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[4],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[4];
                              showItemList.clear();
                              showItemList.addAll(desserts);
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
        VerticalDivider(
          thickness: 0.4,
          color: Colors.black,
        ),
        Expanded(
          flex: 7,
          child: Container(
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


  CategoryWidget({String label, Function(bool) onSelected}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
      child: ChoiceChip(
        key: Key(label),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(50.0),
        ),
        selectedColor: Colors.green,
        backgroundColor: Colors.green.shade50,
        padding: const EdgeInsets.all(10.0),
        label: SizedBox(
          width: double.infinity,
          child: Text(
            label,
            style: TextStyle(
                color: selectedCat == label ? Colors.white : Colors.green,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        selected: selectedCat == label,
        onSelected: onSelected,
      ),
    );
  }


  void getData() async{
   List<Map> result = await repository.getAllMenu();
   for(int i = 0 ; i< result.length ; i ++){
     allItems.add(Item.fromMap(result[i]));
     if(result[i][Sql.Category] == Utils.MainMenu){
       mainMenu.add(Item.fromMap(result[i]));
     }else if(result[i][Sql.Category] == Utils.SoftDrink){

     }else if(result[i][Sql.Category] == Utils.AlcoholicDrink){

     }else if(result[i][Sql.Category] == Utils.Desserts){
       desserts.add(Item.fromMap(result[i]));
     }
   }
   setState(() {
     showItemList.addAll(allItems);//default show is all
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

