import 'dart:convert';
import 'dart:io';

import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/home/log_in.dart';
import 'package:bar_mega/injection_container.dart';
import 'package:bar_mega/model/BtDevice.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:bar_mega/widgets/ListItem.dart';
import 'package:bar_mega/widgets/Toasts.dart';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class PrinterSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice _selectedDevice;

  // List<BluetoothDevice> _devices = [];
  // List<ListItem<BluetoothDevice>> _devices = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  MainRepository repository;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    repository = sl<MainRepository>();
    _onScanPressed();
    // getDevices();
    setSharedPreferece();
  }

  @override
  void dispose() {
    super.dispose();
    // _bluePrintPos.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer Settings"),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: InkWell(
              onTap: () {
                backUpData();
              },
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.backup,
                        color: Colors.green,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'BackUp',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("IsLogin", false);
                String userId = prefs.getString("UserId");
                FirebaseFirestore.instance
                    .collection(Utils.firestore_collection)
                    .doc(userId)
                    .update({
                  "isActive": false,
                }).then((_) {
                  prefs.setString("UserId", "");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false);
                });
              },
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.green,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SmartRefresher(
          onRefresh: _refresh,
          controller: _refreshController,
          child: ListView.builder(

            itemCount: _blueDevices.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // _blueDevices[index].address ==
                // (_selectedDevice?.address ?? '')
                // ? _onDisconnectDevice
                // : () =>
                _onSelectDevice(index);
                // _connect(_blueDevices[index], index);
                // _connect(_devices[index].data ,index);
              },
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.bluetooth,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text(_blueDevices[index].name),
                    subtitle: Text(_blueDevices[index].connected
                        ? "Connected"
                        : "Tap to Connect"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _connect(BlueDevice device, int index) {
  //   try {
  //     if (!_bluePrintPos.isConnected) {
  //       _bluePrintPos.connect(device).then((value) => {
  //             print("======================================>${value}"),
  //             setState(() {
  //               BtDevice bt = BtDevice(
  //                   name: device.name,
  //                   address: device.address,
  //                   type: device.type,
  //                   connected: device.connected);
  //               prefs.setString("Printer", jsonEncode(bt));
  //               print('Connected Bluetooth device' + device.name);
  //               _blueDevices[index].connected = true;
  //               Utils.lstDevices = _blueDevices;
  //             }),
  //           });
  //     } else {
  //       _bluePrintPos.disconnect().then((value) => {
  //             setState(() {
  //               for (int i = 0; i < _blueDevices.length; i++) {
  //                 _blueDevices[i].connected = false;
  //               }
  //               _blueDevices[value.index].connected = false;
  //               Utils.lstDevices = [];
  //             }),
  //           });
  //     }
  //     // _bluePrintPos.isConnected.then((isConnected) => {
  //     //   if(!isConnected){
  //     //     _bluePrintPos.connect(device).then((value) => {
  //     //       setState(() {
  //     //         BtDevice bt = BtDevice(name:device.name,address:device.address,type: device.type,connected: device.connected);
  //     //         prefs.setString("Printer",jsonEncode(bt));
  //     //
  //     //         _devices[index].isSelected = true;
  //     //         Utils.lstDevices = _devices;
  //     //       }),
  //     //     }),
  //     //   }else{
  //     //     bluetooth.disconnect().then((value) => {
  //     //       if(value){
  //     //         setState(() {
  //     //           for(int i = 0 ; i < _devices.length ; i ++){
  //     //             _devices[i].isSelected = false;
  //     //           }
  //     //           Utils.lstDevices = [];
  //     //         }),
  //     //       }
  //     //     }),
  //     //   }
  //     //
  //     // });
  //
  //   } on PlatformException {}
  // }

  // void getDevices() async {
  //   List<BluetoothDevice> devices = [];
  //   List<ListItem<BluetoothDevice>> lst = [];
  //   var isOn = await _bluePrintPos.;
  //   if (!isOn) {
  //     Utils.lstDevices = [];
  //     Utils.confirmDialog(context, "Confirm", "Please open bluetooth!")
  //         .then((value) => {
  //       if (value)
  //         {
  //           bluetooth.openSettings,
  //         }
  //     });
  //   }
  //   try {
  //     devices = await bluetooth.getBondedDevices();
  //   } on PlatformException {
  //     // TODO - Error
  //   }
  //
  //   if (!mounted) return;
  //   for (int i = 0; i < devices.length; i++) {
  //     lst.add(ListItem<BluetoothDevice>(devices[i]));
  //   }
  //   setState(() {
  //     if(Utils.lstDevices.length > 0 ){
  //       _devices = Utils.lstDevices;
  //     }else{
  //       _devices = lst;
  //     }
  //   });
  // }

  Future<void> _onScanPressed() async {
    // setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          // _isLoading = false;
        });
      } else {
        // setState(() => _isLoading = false);

        print("BLUETOOTH DEVICES" + _blueDevices.length.toString());
      }
    });
  }

  void _onSelectDevice(int index) {
    // setState(() {
    //   _isLoading = true;
    //   _loadingAtIndex = index;
    // });
    // BlueDevice(name: ,address: )

    BlueDevice blueDevice =
        _blueDevices[index]; //todo get sharedPreferecne
    String printerJson = prefs.get("Printer") ?? "";
    BtDevice bt = printerJson.isNotEmpty
        ? BtDevice.fromJson(json.decode(printerJson))
        : null;
    if(bt!=null){
      blueDevice = BlueDevice(name: bt.name, address: bt.address);
    }
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      print("---------> ${status}");
      if (status == ConnectionStatus.connected) {
        //printReceipt();
        setState((){
          BtDevice bt = BtDevice(name:blueDevice.name,address:blueDevice.address,type: blueDevice.type,connected: blueDevice.connected);
          prefs.setString("Printer",jsonEncode(bt));
          _selectedDevice= blueDevice;
          _blueDevices[index].connected = true;
          Utils.lstDevices = _blueDevices;
          Toasts.greenToast('Successfully Connected to Printer');
        }
      );
        print('Selected Device' + blueDevice.name);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice(index);
      } else {
        print('$runtimeType - something wrong');
      }
      // setState(() => _isLoading = false);
    });
  }

  void _onDisconnectDevice(int index) {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
          _blueDevices[index].connected = false;
          Utils.lstDevices = [];
          Toasts.greenToast('Disconnected from Printer');
        });
      }
    });
  }

  Future<void> _refresh() async {
    _onScanPressed();
    // getDevices();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void setSharedPreferece() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Future<File> generatePdf() async{
  //     const double inch = 72.0;
  //     const double cm = inch / 2.54;
  //     final doc = pw.Document(pageMode: PdfPageMode.fullscreen,title: "Hello",deflate: zlib.encode);
  //     final  font = await rootBundle.load("assets/font/Roboto-Regular.ttf");
  //     final  ttf = pw.Font.ttf(font);
  //     doc.addPage(pw.Page(
  //         theme: pw.ThemeData.withFont(
  //           base: pw.Font.ttf(await rootBundle.load("assets/font/NotoSerifMyanmar_Regular.ttf")),
  //           bold:  pw.Font.ttf(await rootBundle.load("assets/font/NotoSerifMyanmar_Regular.ttf")),
  //         ),
  //         pageFormat: PdfPageFormat.roll80.copyWith(height: 20 * cm),
  //         build: (pw.Context context) {
  //           return  pw.Center(
  //               child: pw.Column(
  //                   children: [
  //                     pw.Center(
  //                         child: pw.Text("Bar Mega",style: pw.TextStyle(
  //                           color:PdfColors.black,
  //                           fontSize: 35,
  //                           font: ttf,
  //                         ))
  //                     ),
  //                     pw.SizedBox(height: 25),
  //                     pw.Row(
  //                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           pw.Expanded(
  //                             flex: 5,
  //                             child:pw.Text("ြကက်သား ‌ေြကာ်"),
  //                           ),
  //                           pw.Text(" ၁ ပွဲ  ",),
  //                           // pw.Text("${controller.text}"),
  //                           pw.Expanded(
  //                             flex: 5,
  //                             child:pw.Text("1500",style: pw.TextStyle(
  //                                 font:ttf,
  //                                 fontSize: 18
  //                             )),
  //                           ),
  //                         ]
  //                     )
  //                   ]
  //               )
  //           );
  //         }));
  //     // final output = await getTemporaryDirectory();
  //     // final file = File('${output.path}/example.pdf');
  //     // return await file.writeAsBytes(await doc.save());
  //     //  await Printing.layoutPdf(onLayout: (format) => doc.save(),format: PdfPageFormat.roll80.copyWith(height: 20 * cm),usePrinterSettings: true);
  //
  //   }
  //
  // void printVoucher() async{
  //   var file = await generatePdf();
  //
  //   print("path => ${file.path}");
  //   // _connectAndPrint(file.path);
  // }
  // _connectAndPrint(String path) {
  //   try {
  //     BlueDevice bt = BlueDevice.fromJson(json.decode(prefs.getString("Printer")));
  //
  //         BluetoothDevice device = BluetoothDevice(bt.name, bt.address);
  //         bluetooth.isConnected.then((isConnected) => {
  //           if (!isConnected)
  //             {
  //               bluetooth.connect(device).then((value) => {
  //                 printInvoice(path),
  //               }),
  //             }
  //         });
  //
  //   } on PlatformException {}
  // }

  // printInvoice(String path) async{
  //   var unit8Lint = await File(path).readAsBytes();
  //   bluetooth.writeBytes(unit8Lint);
  //   bluetooth.paperCut();
  // }

  void backUpData() async {
    // bool isEncrypted = true;
    // var result = await repository.backUpData(isEncrypted);

    Directory dbDirectory = await getApplicationDocumentsDirectory();
    File source1 = File('${dbDirectory.path}/barMega.db');

    // Directory copyTo = Directory("storage/emulated/0/BarMega Backup");
    // if ((await copyTo.exists())) {
    //   var status = await Permission.storage.status;
    //   if (!status.isGranted) {
    //     await Permission.storage.request();
    //   }
    // } else {
    //   print("not exist");
    //   if (await Permission.storage.request().isGranted) {
    //     // Either the permission was already granted before or the user just granted it.
    //     await copyTo.create();
    //   } else {
    //     Toasts.greenToast('Please give permission');
    //   }
    // }

    Directory dir = Directory(
        (await getExternalStorageDirectory()).path + '/BarMega BackUp');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
    } else {
      dir.createSync(recursive: true);
    }
    print("${dir.path}");
    String newPath = "${dir.path}/barMega.db";
    await source1.copy(newPath);
  }

  void restoreDb() async {
    // var directory = await getApplicationDocumentsDirectory();
    // var dbPath = join(directory.path, 'barMega.db');

    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   File source = File(result.files.single.path);
    //   await source.copy(dbPath);
    //   setState(() {
    //    var message = 'Successfully Restored DB';
    //   });
    // } else {
    //   // User canceled the picker
    //
    // }
  }
}
