import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart';
import 'package:bar_mega/db/DbAccess.dart';
import 'package:bar_mega/menu/MenuDetail.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/Utils.dart';
import '../injection_container.dart';

class ItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<String> cats = Utils.categoryList;
  String selectedCat;

  @override
  void initState() {
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
                              BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[1],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[1];
                              BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(selectedCat));

                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[2],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[2];
                              BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(selectedCat));

                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[3],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[3];
                              BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(selectedCat));
                            });
                          }
                        }),
                    CategoryWidget(
                        label: cats[4],
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedCat = cats[4];
                              BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(selectedCat));
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
          child: BlocBuilder<MenuBloc,MenuState>(
            builder: (context,state){
              if(state is Success){
               return Container(
                  child: GridView.count(
                    crossAxisCount: 5,
                    scrollDirection: Axis.vertical,
                    children: List.generate(state.result.length, (index) {
                      return InkWell(child: MenuItem(state.result[index]),onTap: (){
                         Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MenuDetail(item: state.result[index],category: selectedCat,)));

                      },);
                    }),
                  ),
                );
            }else if(state is Failure){
                return Center(
                  child: Text(state.message),
                );
              }else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.green,),
                );
              }
            },
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
                  MaterialPageRoute(builder: (context) => MenuDetail(category: selectedCat,)));

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
      padding: const EdgeInsets.only(top: 14.0, left: 10.0, right: 10.0),
      child: ChoiceChip(
        key: Key(label),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(50.0),
        ),
        selectedColor: Colors.green,
        backgroundColor: Colors.green.shade50,
        padding: const EdgeInsets.all(16.0),
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
    BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
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
          Flexible(
            child: Container(
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
          ),
          Divider(
            height: 0.4,
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: Text(
              item.nameEng,
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

