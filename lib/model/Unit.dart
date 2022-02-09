class Unit{

  int unitId;
  String name;

  Unit({this.unitId, this.name});

  Unit.fromMap(Map<String, dynamic> map)
        : unitId = map['unitId'],
         name = map['name'];
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['unitId'] = unitId;
    map['name'] = name;
    return map;
  }
}