import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TableDetail extends StatefulWidget{
  final String title;
  final Desk desk;
  TableDetail({this.title,this.desk});
  @override
  State<StatefulWidget> createState() => _TableDetialState();

}

class _TableDetialState extends State<TableDetail> {
  String buttonText = "Save";
  String status = "Available";

  TextEditingController tableNoController = TextEditingController();
  TextEditingController noOfSeatsController = TextEditingController();

  // Desk desk = Desk(deskId: ,tableNo: ,noOfSeats: ,status: );
  @override
  void initState() {
    if(widget.desk != null){
      buttonText = "Update";
      tableNoController.text = widget.desk.tableNo;
      noOfSeatsController.text = widget.desk.noOfSeats.toString();
      status = widget.desk.status;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          widget.title =="Update Table" ? IconButton(onPressed: (){
           deleteTable(widget.desk);
          }, icon: Icon(Icons.delete,color: Colors.white,size: 32,)):SizedBox.shrink(),
          SizedBox(width: 20,),
        ],
      ),
      body: BlocListener<TableBloc,TableState>(
        listener: (context,state){
          if (state is SaveSuccess) {
              BlocProvider.of<TableBloc>(context).add(GetAllTable());
            Navigator.of(context).pop();
          }
        },
       child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Card(
                      shadowColor: Colors.grey,
                      elevation: 5.0,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Table No."),
                                SizedBox(
                                  width: 10,
                                ),
                                inputWidget(
                                    width: width * 0.3,
                                    controller: tableNoController),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("No. of Seats"),
                                SizedBox(
                                  width: 10,
                                ),
                                inputWidget(
                                    width: width * 0.3,
                                    controller: noOfSeatsController),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: width * 0.17,
                                  child: buttonWidget(
                                      text: buttonText,
                                      color: Colors.black,
                                      fontSize: 20,
                                      spacing: 1,
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        if (tableNoController.text
                                            .trim()
                                            .isNotEmpty && noOfSeatsController.text
                                            .trim()
                                            .isNotEmpty) {
                                          if(buttonText =="Save"){
                                            saveTable();
                                          }else{
                                             updateTable();
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Please fill all field!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            fontSize: 13,
                                            backgroundColor: Colors.green,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                          );
                                        }
                                      }),
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Container(
                                  width: width * 0.17,
                                  child: buttonWidget(
                                      text: "Cancel",
                                      color: Colors.black,
                                      fontSize: 20,
                                      spacing: 1,
                                      fontWeight: FontWeight.bold,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void saveTable() {
    BlocProvider.of<TableBloc>(context).add(SaveTable(Desk(
        tableNo: tableNoController.text,
        noOfSeats: int.parse(noOfSeatsController.text),
        status: status)));
  }

  void updateTable() {
    BlocProvider.of<TableBloc>(context).add(UpdateTable(Desk(
        deskId: widget.desk.deskId,
        tableNo: tableNoController.text,
        noOfSeats: int.parse(noOfSeatsController.text),
        status: status)));
  }

  void deleteTable(Desk desk) {
    BlocProvider.of<TableBloc>(context).add(DeleteTable(desk));
  }

}
Widget inputWidget({double width, TextEditingController controller}) {
  return Container(
    width: width,
    height: 50,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, style: BorderStyle.solid),
    ),
    child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
        )),
  );
}

Widget buttonWidget({String text,
  Color color,
  double fontSize,
  double spacing,
  FontWeight fontWeight,
  Function() onTap}) {
  return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      color: CupertinoColors.activeGreen,
      child: Text(text,
          style: TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: spacing)),
      onPressed: onTap);
}