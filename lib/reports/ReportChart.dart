import 'package:bar_mega/reports/ReportList.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/repository/SaleRepository.dart';
import 'package:bar_mega/widgets/ReportData.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../common/Utils.dart';
import '../injection_container.dart';
import '../widgets/custom_button.dart';

class ReportChart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ReportChartState();

}

class _ReportChartState extends State<ReportChart> {
  final Color leftBarColor = Colors.blue; //const Color(0xff53fdd7);
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  final defaultReportData = [
    new ReportData('Sales', 0),
    new ReportData('Purchase', 0)
  ];

  SaleRepository repository = sl<SaleRepository>();

  List<charts.Series<ReportData, String>> reportData;

  @override
  void initState() {
    reportData = [
      new charts.Series<ReportData, String>(
        id: 'report',
        domainFn: (ReportData data, _) => data.label,
        measureFn: (ReportData sales, _) => sales.sales,
        data: defaultReportData,
        labelAccessorFn: (ReportData sale, _) => '${sale.sales.toString()}',
      ),
    ];
    loadChartData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var chartWidget = charts.BarChart(
      reportData,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 17.toInt(), // size in Pts.
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        renderSpec: new charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: new charts.TextStyleSpec(
            fontSize: 16.toInt(), // size in Pts.
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      barRendererDecorator: new charts.BarLabelDecorator<String>(
        insideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 14.toInt(),
            color: charts.Color(
              r: 255,
              g: 255,
              b: 255,
            ),
            fontWeight: "144"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportList()),
                );
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
                      Text(
                        'Sales Report',
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
      body: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            4.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: Text(
                              "${this._fromDate.day} / ${this._fromDate.month} / ${this._fromDate.year}",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                currentTime: this._fromDate,
                                theme: Utils.kDateTimePickerTheme,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() {
                                    this._fromDate = date;
                                  });
                                  loadChartData();
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '-',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: Text(
                              this._toDate != null
                                  ? "${this._toDate.day} / ${this._toDate.month} / ${this._toDate.year}"
                                  : "Select Date",
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                currentTime: this._toDate,
                                theme: Utils.kDateTimePickerTheme,
                                minTime: this._fromDate,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() {
                                    this._toDate = date;
                                  });
                                  loadChartData();
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: chartWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadChartData() async {

    List<Sale>  saleList = await repository.getAllSale();
    List<PurchaseItemModel>  purchaseList = await repository.getAllPurchase();

    var sale = saleList
        .where((sale) {
      return
          Utils.isEqualDateFilter(
              new DateFormat("dd-MM-yyyy").parse(sale.date),
              this._fromDate,
              this._toDate);
    })
        .toList();

    var purchase = purchaseList
        .where((purchase) {
      return
        Utils.isEqualDateFilter(
            new DateFormat("dd-MM-yyyy").parse(purchase.date),
            this._fromDate,
            this._toDate);
    })
        .toList();
    double saleAmount = sale.fold(0, (sum, item) => sum + double.parse(item.total));
    double purchaseAmount = purchase.fold(0, (sum, item) => sum + double.parse(item.price));


    List<ReportData> report = [
      new ReportData('Sales', saleAmount),
      new ReportData('Purchase', purchaseAmount),
    ];
    setState(() {
      reportData = [
        new charts.Series<ReportData, String>(
          id: 'report',
          measureFn: (ReportData sales, _) => sales.sales,
          data: report,
          labelAccessorFn: (ReportData sale, _) => '${sale.sales.toString()}',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(leftBarColor),
          domainFn: (ReportData sales, _) => sales.label,
        ),
      ];
    });
  }
}