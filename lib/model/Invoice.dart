class Invoice{
  int invoiceNo;
  int deskId;


  Invoice({this.invoiceNo, this.deskId});

  Invoice.fromMap(Map<String, dynamic> map)
      : invoiceNo = map['invoiceNo'],
        deskId = map['deskId'];
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['invoiceNo'] = invoiceNo;
    map['deskId'] = deskId;
    return map;
  }
}