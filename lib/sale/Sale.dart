import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart';
import 'package:bar_mega/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/Utils.dart';
import '../injection_container.dart';
import '../model/Item.dart';
import '../model/Order.dart';
import '../repository/MainRepository.dart';
import 'OrderDetails.dart';
import 'empty_cart.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> cats = Utils.categoryList;
  String selectedCat;
  List<Order> cartItems = [];
  double total = 0.0;

  @override
  void initState() {
    selectedCat = cats[0];
    getData(); //get menu from db
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
                              });
                              BlocProvider.of<MenuBloc>(context)
                                  .add(GetAllMenu());
                            }
                          }),
                      CategoryWidget(
                          label: cats[1],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[1];
                              });
                              BlocProvider.of<MenuBloc>(context)
                                  .add(GetMenuByCategory(selectedCat));
                            }
                          }),
                      CategoryWidget(
                          label: cats[2],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[2];
                              });
                              BlocProvider.of<MenuBloc>(context)
                                  .add(GetMenuByCategory(selectedCat));
                            }
                          }),
                      CategoryWidget(
                          label: cats[3],
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                selectedCat = cats[3];
                              });
                              BlocProvider.of<MenuBloc>(context)
                                  .add(GetMenuByCategory(selectedCat));
                            }
                          }),
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 6,
            child: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
              if (state is Success) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(state.result.length, (index) {
                      return InkWell(
                        child: SaleItem(state.result[index]),
                        onTap: () {
                          var item = state.result[index];
                          int itemIndex = cartItems
                              .indexWhere((e) => e.itemName == item.nameEng);
                          cartItems.forEach((e) => print(e.itemName));
                          setState(() {
                            if (itemIndex == -1) {
                              Order orderItem = Order(
                                  itemName: item.nameEng,
                                  qty: 1,
                                  price: item.price,
                                  total: item.price);
                              _listKey.currentState.insertItem(0,
                                  duration: const Duration(milliseconds: 500));
                              cartItems = []
                                ..add(orderItem)
                                ..addAll(cartItems);
                            } else {
                              cartItems[itemIndex].qty += 1;
                              cartItems[itemIndex].total =
                                  cartItems[itemIndex].price *
                                      cartItems[itemIndex].qty;
                            }
                            // total = getTotalPrice();
                          });
                          // OnItemSelect(item: itemList[index]);
                        },
                      );
                    }),
                  ),
                );
              } else if (state is Failure) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
            }),
          ),
          Expanded(
            flex: 4,
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
                                        left: 10.0, top: 4.0, right: 10.0),
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
                          onTap: () {
                            OrderList().setList = cartItems;
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => OrderDetails()));
                          },
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

  getTotalPrice() {
    int t = 0;
    return cartItems.forEach((e) => t += int.parse(e.total));
  }

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

  CartItem({Order item}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        shadowColor: Colors.white54,
        child: Padding(
          padding: EdgeInsets.all(2.0),
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
                          Future.delayed(Duration(milliseconds: 550), () {
                            setState(() {
                              cartItems.removeAt(cartItems.indexOf(item));
                            });
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
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${item.price} Ks',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
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
                                    if (item.qty > 1) {
                                      setState(() {
                                        --item.qty;
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
                                '${item.qty}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ClipOval(
                              child: Material(
                                color: Colors.green.shade50, // Button color
                                child: InkWell(
                                  splashColor: Colors.green, // Splash color
                                  onTap: () {
                                    setState(() {
                                      ++item.qty;
                                      // item.total += item.price;
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

  void getData() {
    BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
  }
}

class SaleItem extends StatelessWidget {
  final Item item;

  SaleItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3.0),
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
                          height: 100,
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  item.nameEng,
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  "${item.price} Ks",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
