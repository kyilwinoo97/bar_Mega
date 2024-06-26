class BtDevice {
   String name;
   String address;
   int type = 0;
  bool connected = false;

   BtDevice({this.name, this.address, this.type, this.connected});

   BtDevice.fromMap(Map map)
      : name = map['name'],
        address = map['address'];

   BtDevice.fromJson(Map<String, dynamic> json,) {
    name = json['name'];
    address = json['address'];
    type = json['type'];
    connected = json['connected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['type'] = this.type;
    data['connected'] = this.connected;
    return data;
  }

  Map<String, dynamic> toMap() => {
    'name': this.name,
    'address': this.address,
    'type': this.type,
    'connected': this.connected,
  };

  operator ==(Object other) {
    return other is BtDevice && other.address == this.address;
  }

  @override
  int get hashCode => address.hashCode;
}
