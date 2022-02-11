import 'dart:math';

import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart' as Menu;
import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart' as sale;
import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Invoice.dart';
import 'package:bar_mega/repository/SaleRepository.dart';
import 'package:bar_mega/widgets/Toasts.dart';
import 'package:bar_mega/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../common/Utils.dart';
import '../injection_container.dart';
import '../model/Item.dart';
import '../model/Order.dart';
import '../repository/MainRepository.dart';
import 'OrderDetails.dart';
import 'empty_cart.dart';

class SaleList extends StatefulWidget {
  final Desk desk;

  SaleList({this.desk});

  @override
  _SaleListState createState() => _SaleListState();
}

class _SaleListState extends State<SaleList> {

  final _discountController = TextEditingController();
  List<String> cats = Utils.categoryList;
  String selectedCat;
  List<Order> cartItems = [];
  double total = 0.0;
  SaleRepository repository ;
  MainRepository mainRepository;
  var invoiceNo;
  @override
  void initState() {
    selectedCat = cats[0];
    repository = sl<SaleRepository>();
    mainRepository = sl<MainRepository>();
    generateInvoiceNo();
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<sale.SaleBloc, sale.SaleState>(
            listener: (context, state) {
              if(state is sale.Success){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderDetails(widget.desk)));
              }else if(state is sale.DeleteSuccess){
                BlocProvider.of<TableBloc>(context).add(UpdateTable(Desk(
                    deskId: widget.desk.deskId,
                    tableNo: widget.desk.tableNo,
                    invoiceNo: "",
                    noOfSeats: widget.desk.noOfSeats,
                    status: "Available")));
                BlocProvider.of<TableBloc>(context).add(GetAllTable());

                setState(() {
                    cartItems.clear();
                    OrderList().setList = [];
                  });
                Navigator.of(context).pop();

              }else if (state is sale.DeleteOneOrderSuccess){

              }
            },
          ),
        ],
        child: Row(
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
                                BlocProvider.of<Menu.MenuBloc>(context)
                                    .add(Menu.GetAllMenu());
                              }
                            }),
                        CategoryWidget(
                            label: cats[1],
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  selectedCat = cats[1];
                                });
                                BlocProvider.of<Menu.MenuBloc>(context)
                                    .add(Menu.GetMenuByCategory(selectedCat));
                              }
                            }),
                        CategoryWidget(
                            label: cats[2],
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  selectedCat = cats[2];
                                });
                                BlocProvider.of<Menu.MenuBloc>(context)
                                    .add(Menu.GetMenuByCategory(selectedCat));
                              }
                            }),
                        CategoryWidget(
                            label: cats[3],
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  selectedCat = cats[3];
                                });
                                BlocProvider.of<Menu.MenuBloc>(context)
                                    .add(Menu.GetMenuByCategory(selectedCat));
                              }
                            }),
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 6,
              child: BlocBuilder<Menu.MenuBloc, Menu.MenuState>(
                  builder: (context, state) {
                if (state is Menu.Success) {
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
                                .indexWhere((e) => e.name == item.name);
                            setState(() {
                              if (itemIndex == -1) {
                                Order orderItem = Order(
                                    invoiceNo: invoiceNo.toString(),
                                    name: item.name,
                                    quantity: 1,
                                    amount: item.price,
                                    unit: item.unit,
                                    discount: "0",
                                    date: Utils.getCurrentDate(),
                                    total: item.price);
                                cartItems = []
                                  ..add(orderItem)
                                  ..addAll(cartItems);
                              } else {
                                cartItems[itemIndex].quantity += 1;
                                cartItems[itemIndex].total = (double.parse(cartItems[itemIndex].amount) * cartItems[itemIndex].quantity).toString();
                              }
                              total = getTotalPrice();
                            });
                          },
                        );
                      }),
                    ),
                  );
                } else if (state is Menu.Failure) {
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
                                      ClipOval(
                                        child: Material(
                                          color: Colors.red.shade50, // Button color
                                          child: InkWell(
                                            splashColor: Colors.red, // Splash color
                                            onTap: () {
                                              BlocProvider.of<sale.SaleBloc>(context).add(sale.RemoveAllOrder(cartItems));
                                            },
                                            child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  Icons.delete_forever,
                                                  size: 20,
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ),
                                      ),
                                        ],
                                      )),
                                  const SizedBox(height: 5.0),
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cartItems.length,
                                      itemBuilder: (context, index) {
                                        return CartItem(item: cartItems[index]);
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
                            label: 'Discount',
                            color: Colors.green,
                            onTap: _showDialog,

                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            label: 'Save',
                            color: Colors.green,
                            onTap: () {
                              if(cartItems.length > 0 ){
                                BlocProvider.of<sale.SaleBloc>(context).add(sale.AddOrder(cartItems));
                                OrderList().setList = cartItems;
                              }else{
                                Toasts.greenToast("Add item first");
                              }

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
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: _discountController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Discount', hintText: '%'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  _discountController.text = '';
                  Navigator.pop(context);
                }),
            new ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  getTotalPrice() {
    double t = 0;
    cartItems.forEach((e) => t += double.parse(e.total));
    return t;
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
                          BlocProvider.of<sale.SaleBloc>(context).add(sale.RemoveOneOrder(item));
                          setState(() {
                            cartItems.removeAt(cartItems.indexOf(item));
                            total = getTotalPrice();
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
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '${item.amount} ks',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                                    if (item.quantity > 1) {
                                      setState(() {
                                        --item.quantity;
                                        item.total = (double.parse(item.amount) *
                                                item.quantity)
                                            .toString();
                                        total = getTotalPrice();
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
                                '${item.quantity}',
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
                                      ++item.quantity;
                                      item.total =
                                          (double.parse(item.amount) * item.quantity)
                                              .toString();
                                      total = getTotalPrice();

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

  void getData() async{
    BlocProvider.of<Menu.MenuBloc>(context).add(Menu.GetAllMenu());
    if (widget.desk.invoiceNo.isNotEmpty) {
      List<Map> result = await repository.getAllOrderByInvoiceNo(widget.desk.invoiceNo);
      List<Order> lst = [];
      for(int i = 0;i< result.length ; i ++){
        lst.add(Order.fromMap(result[i]));
      }
      setState(() {
        cartItems.addAll(lst);
        total = getTotalPrice();
      });
    }
  }

  void generateInvoiceNo() async{
    //invoiceNo exist in table do not create
    if(widget.desk.invoiceNo.isEmpty){
      invoiceNo =await repository.addInvoice(Invoice(deskId: widget.desk.deskId));
      BlocProvider.of<TableBloc>(context).add(UpdateTable(Desk(
          deskId: widget.desk.deskId,
          tableNo: widget.desk.tableNo,
          invoiceNo: invoiceNo.toString(),
          noOfSeats: widget.desk.noOfSeats,
          status: "Not Available")));
      BlocProvider.of<TableBloc>(context).add(GetAllTable());
    }else{
      invoiceNo = widget.desk.invoiceNo;
    }
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
                  item.name,
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
