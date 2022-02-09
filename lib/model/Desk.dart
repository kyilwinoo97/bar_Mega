class Desk{
  int deskId;
  String tableNo;
  int noOfSeats;
  String status; //available or present

  Desk({this.deskId, this.tableNo, this.noOfSeats,
      this.status});
  Desk.fromMap(Map<String, dynamic> map)
      : deskId = map['deskId'],
        tableNo = map['tableNo'],
        noOfSeats = map['noOfSeats'],
        status = map['status'];
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['deskId'] = deskId;
    map['tableNo'] = tableNo;
    map['noOfSeats'] = noOfSeats;
    map['status'] = status;
    return map;
  }
}