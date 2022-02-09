import 'package:flutter/material.dart';

import '../injection_container.dart';
import '../model/Item.dart';
import '../repository/MainRepository.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  MainRepository repository;
  List<Item> itemList = [];
  List<Item> allItem = [
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),

    //testing
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
  ];
  List<Item> softItem = [
    Item(
        itemId: 1,
        unitId: 0,
        name: "Cocacola",
        price: 1000,
        unit: "Cup",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Blue mountain",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Pepsi",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "M - 150",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Shark",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Red Bull",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 1,
        unitId: 0,
        name: "Lipo",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
  ];
  List<String> cats = ['All', 'Soft Drink', 'Alcoholic Drink', 'Desserts'];
  String selectedCat;
  List<Item> cartItems = [];
  //category => main menu,alcoholic drink,soft drink ,desserts
  @override
  void initState() {
    selectedCat = cats[0];
    repository = sl<MainRepository>();
    itemList.addAll(allItem);
    //Todo get data from database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.print)),
          const SizedBox(width: 10.0),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: Card(
                  shadowColor: Colors.white30,
                  elevation: 5.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      CategoryWidget(
                          label: cats[0],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[0];
                                itemList.clear();
                                itemList.addAll(allItem);
                              });
                            }
                          }),
                      CategoryWidget(
                          label: cats[1],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[1];
                                itemList.clear();
                                itemList.addAll(softItem);
                              });
                            }
                          }),
                      CategoryWidget(
                          label: cats[2],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[2];
                                itemList.clear();
                              });
                            }
                          }),
                      CategoryWidget(
                          label: cats[3],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[3];
                                itemList.clear();
                              });
                            }
                          }),
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(itemList.length, (index) {
                  return InkWell(
                    child: SaleItem(itemList[index]),
                    onTap: () {
                      setState(() {
                        cartItems.add(itemList[index]);
                      });
                    },
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: Card(
                  shadowColor: Colors.white30,
                  elevation: 5.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          "assets/images/menu.png",
                          height: 50,
                          width: 50,
                        ),
                        title: Text('Test'),
                        trailing: Text('20'),
                      )
                    ],
                  )),
            ),
          )
        ],
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
        padding: const EdgeInsets.all(5.0),
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
}

class SaleItem extends StatelessWidget {
  final Item item;

  SaleItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(0.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        shadowColor: Colors.white30,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
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
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.green, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
