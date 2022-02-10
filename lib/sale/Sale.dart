import 'package:bar_mega/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../injection_container.dart';
import '../model/Item.dart';
import '../repository/MainRepository.dart';
import 'empty_cart.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

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
        itemId: 2,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 3,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 4,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 5,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 6,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 7,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),

    //testing
    Item(
        itemId: 8,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 9,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 10,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 11,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 12,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 13,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 14,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 15,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 16,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 17,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 18,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 19,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
    Item(
        itemId: 20,
        unitId: 0,
        name: "Salad",
        price: 1000,
        unit: "Cup",
        category: "Food",
        path: ""),
  ];
  List<Item> softItem = [
    Item(
        itemId: 21,
        unitId: 0,
        name: "Cocacola",
        price: 1000,
        unit: "Cup",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 22,
        unitId: 0,
        name: "Blue mountain",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 23,
        unitId: 0,
        name: "Pepsi",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 24,
        unitId: 0,
        name: "M - 150",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 25,
        unitId: 0,
        name: "Shark",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 26,
        unitId: 0,
        name: "Red Bull",
        price: 1000,
        unit: "bottle",
        category: "Soft Drink",
        path: ""),
    Item(
        itemId: 27,
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
  double total = 0.0;
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
        elevation: 0.0,
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
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(itemList.length, (index) {
                  return InkWell(
                    child: SaleItem(itemList[index]),
                    onTap: () {
                      var item = itemList[index];
                      setState(() {
                        cartItems.add(item);
                        _listKey.currentState.insertItem(0,
                            duration: const Duration(milliseconds: 500));
                        cartItems = []
                          ..add(item)
                          ..addAll(cartItems);
                      });
                      // OnItemSelect(item: itemList[index]);
                    },
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                    flex: 9,
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      height: double.infinity,
                      child: Card(
                          shadowColor: Colors.white30,
                          elevation: 5.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, top: 15.0, right: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cart',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        PopupMenuButton(
                                          child: Card(
                                              margin: EdgeInsets.all(5.0),
                                              shadowColor:
                                                  Colors.green.shade100,
                                              elevation: 0.0,
                                              color: Colors.green.shade100,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                  'Table 1',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              )),
                                          onSelected: (val) {},
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem(
                                              child: ListTile(
                                                title: Text('Table 1'),
                                              ),
                                              value: 'table 1',
                                            ),
                                            PopupMenuItem(
                                              child: ListTile(
                                                title: Text('Table 2'),
                                              ),
                                              value: 'table 2',
                                            ),
                                            PopupMenuItem(
                                              child: ListTile(
                                                title: Text('Table 3'),
                                              ),
                                              value: 'table 3',
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                const SizedBox(height: 5.0),
                                AnimatedList(
                                    key: _listKey,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    initialItemCount: cartItems.length,
                                    itemBuilder: (context, index, animation) {
                                      return AnimateCartItem(
                                          context, index, animation);
                                    }),
                              ],
                            ),
                          )),
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                            shadowColor: Colors.green.shade100,
                            elevation: 0.0,
                            color: Colors.green.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                                child: Text(
                              '$total Ks',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          label: 'Cancel',
                          color: Colors.red,
                          onTap: () {
                            setState(() {
                              cartItems.clear();
                              _listKey = GlobalKey();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          label: 'Order',
                          color: Colors.green,
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // OnItemSelect({item}) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //             actions: [
  //               ClipOval(
  //                 child: Material(
  //                   color: Colors.red, // Button color
  //                   child: InkWell(
  //                     splashColor: Colors.red.shade50, // Splash color
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: SizedBox(
  //                         width: 50,
  //                         height: 50,
  //                         child: Icon(
  //                           Icons.remove,
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(width: 10.0),
  //               ClipOval(
  //                 child: Material(
  //                   color: Colors.green, // Button color
  //                   child: InkWell(
  //                     splashColor: Colors.green, // Splash color
  //                     onTap: () {
  //                       setState(() {
  //                         cartItems.add(item);
  //                         _listKey.currentState.insertItem(0,
  //                             duration: const Duration(milliseconds: 700));
  //                         cartItems = []
  //                           ..add(item)
  //                           ..addAll(cartItems);
  //                       });
  //                       Navigator.pop(context);
  //                     },
  //                     child: SizedBox(
  //                         width: 50,
  //                         height: 50,
  //                         child: Icon(
  //                           Icons.done,
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                 ),
  //               )
  //             ],
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   '${item.name}',
  //                   style: TextStyle(color: Colors.green, fontSize: 22.0),
  //                 ),
  //                 Text(
  //                   '${item.price} Ks',
  //                   style: TextStyle(color: Colors.green, fontSize: 17.0),
  //                 )
  //               ],
  //             ),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Image.asset(
  //                   'assets/images/menu.png',
  //                   width: 150.0,
  //                   height: 150.0,
  //                 ),
  //                 Padding(
  //                     padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         ClipOval(
  //                           child: Material(
  //                             color: Colors.green.shade50, // Button color
  //                             child: InkWell(
  //                               splashColor: Colors.green, // Splash color
  //                               onTap: () {
  //                                 if (item.count > 1) {
  //                                   setState(() {
  //                                     --item.count;
  //                                   });
  //                                 }
  //                               },
  //                               child: SizedBox(
  //                                   width: 50,
  //                                   height: 50,
  //                                   child: Icon(
  //                                     Icons.remove,
  //                                     color: Colors.green,
  //                                   )),
  //                             ),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.symmetric(horizontal: 5.0),
  //                           child: Text('${item.count}'),
  //                         ),
  //                         ClipOval(
  //                           child: Material(
  //                             color: Colors.green.shade50, // Button color
  //                             child: InkWell(
  //                               splashColor: Colors.green, // Splash color
  //                               onTap: () {
  //                                 setState(() {
  //                                   ++item.count;
  //                                 });
  //                               },
  //                               child: SizedBox(
  //                                   width: 50,
  //                                   height: 50,
  //                                   child: Icon(
  //                                     Icons.add,
  //                                     color: Colors.green,
  //                                   )),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     )),
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }

  onRemove(int index) {
    var item = cartItems.removeAt(index);
    _listKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: CartItem(item: item),
          ),
        );
      },
      duration: Duration(milliseconds: 600),
    );
  }

  Widget AnimateCartItem(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: InkWell(
        child: CartItem(item: cartItems[index]),
        onTap: () {
          setState(() {});
        },
      ),
    );
  }

  CartItem({item}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(0.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        shadowColor: Colors.white54,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: ClipOval(
                    child: Material(
                      color: Colors.red.shade50, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: () {
                          if (cartItems.length < 1) return;
                          _listKey.currentState.removeItem(
                              cartItems.indexOf(item),
                              (_, animation) => AnimateCartItem(
                                  context, cartItems.indexOf(item), animation),
                              duration: const Duration(milliseconds: 500));
                          setState(() {
                            cartItems.removeAt(cartItems.indexOf(item));
                          });
                        },
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
                  )),
              const SizedBox(height: 2.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${item.price} Ks',
                      style: TextStyle(color: Colors.green, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.green.shade50, // Button color
                          child: InkWell(
                            splashColor: Colors.green, // Splash color
                            onTap: () {
                              if (item.count > 1) {
                                setState(() {
                                  --item.count;
                                });
                              }
                            },
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          '${item.count}',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.green.shade50, // Button color
                          child: InkWell(
                            splashColor: Colors.green, // Splash color
                            onTap: () {
                              setState(() {
                                ++item.count;
                              });
                            },
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  CategoryWidget({String label, Function(bool) onSelected}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
          child: Flex(
            direction: Axis.vertical,
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
                          height: 120,
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
