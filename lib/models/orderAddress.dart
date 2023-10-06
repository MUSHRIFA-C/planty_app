class OrderAddress {
  int? id;
  String? name;
  String? contact;
  String? pincode;
  String? city;
  String? state;
  String? area;
  String? buildingName;
  String? landmark;
  String? addressType;
  String? orderAddressStatus;
  int? user;

  OrderAddress(
      {this.id,
        this.name,
        this.contact,
        this.pincode,
        this.city,
        this.state,
        this.area,
        this.buildingName,
        this.landmark,
        this.addressType,
        this.orderAddressStatus,
        this.user});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    area = json['area'];
    buildingName = json['buildingName'];
    landmark = json['landmark'];
    addressType = json['addressType'];
    orderAddressStatus = json['orderAddressStatus'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['area'] = this.area;
    data['buildingName'] = this.buildingName;
    data['landmark'] = this.landmark;
    data['addressType'] = this.addressType;
    data['orderAddressStatus'] = this.orderAddressStatus;
    data['user'] = this.user;
    return data;
  }
}